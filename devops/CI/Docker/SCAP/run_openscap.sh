# shellcheck shell=sh
          set -eu
          # extract /etc/os-release
          container_id=$(docker create "${IMAGE_NAME}")
          if ! docker export "${container_id}" | tar -tvf - | grep -E '\setc/os-release( ->.*)?$' > /dev/null 2>&1 ; then
            >&2 echo "The operating system used by ${IMAGE_NAME} could not be detected."
            >&2 echo "Images that are not based on an operating system (such as distroless images) cannot be scanned by SCAP."
            exit 1
          fi
          docker cp -L "$container_id:/etc/os-release" .
          docker rm "$container_id"
          unset container_id
          # determine which ssg to use based on /etc/os-release
          # see https://www.freedesktop.org/software/systemd/man/os-release.html
          version_id=$(awk -F= '$1=="VERSION_ID" { print $2 ;}' os-release | sed 's/"//g')
          id=$(awk -F= '$1=="ID" { print $2 ;}' os-release | sed 's/"//g')
          if [ "${id}" = "ubuntu" ] && echo "${version_id}" | grep -qE '^18\.04(\..*)?$' ; then
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-ubuntu1804-ds.xml"
          elif [ "${id}" = "ubuntu" ] && echo "${version_id}" | grep -qE '^20\.04(\..*)?$' ; then
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-ubuntu2004-ds.xml"
          elif [ "${id}" = "ubuntu" ] && echo "${version_id}" | grep -qE '^22\.04(\..*)?$' ; then\
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-ubuntu2204-ds.xml"
          elif [ "${id}" = "centos" ] && echo "${version_id}" | grep -qE '^7(\..*)?$' ; then
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-centos7-ds.xml"
          elif [ "${id}" = "centos" ] && echo "${version_id}" | grep -qE '^8(\..*)?$' ; then
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-centos8-ds.xml"
          elif [ "${id}" = "ol" ] && echo "${version_id}" | grep -qE '^7(\..*)?$' ; then
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-ol7-ds.xml"
          elif [ "${id}" = "ol" ] && echo "${version_id}" | grep -qE '^8(\..*)?$' ; then
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-ol8-ds.xml"
          elif [ "${id}" = "ol" ] && echo "${version_id}" | grep -qE '^9(\..*)?$' ; then
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-ol9-ds.xml"
          elif [ "${id}" = "rhel" ] && echo "${version_id}" | grep -qE '^7(\..*)?$' ; then
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-rhel7-ds.xml"
          elif [ "${id}" = "rhel" ] && echo "${version_id}" | grep -qE '^8(\..*)?$' ; then
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-rhel8-ds.xml"
          elif [ "${id}" = "rhel" ] && echo "${version_id}" | grep -qE '^9(\..*)?$' ; then
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-rhel9-ds.xml"
          elif [ "${id}" = "sles" ] && echo "${version_id}" | grep -qE '^12(\..*)?$' ; then
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-sle12-ds.xml"
          elif [ "${id}" = "sles" ] && echo "${version_id}" | grep -qE '^15(\..*)?$' ; then
            ssg="scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}/ssg-sle15-ds.xml"
          else
            >&2 echo "There is no configuration available for ${id} ${version_id}"
            exit 1
          fi
          # Select the profile to use. The first profile that exists in the ssg is used.
          for profile in xccdf_org.ssgproject.content_profile_cis_level2_server xccdf_org.ssgproject.content_profile_cis xccdf_org.ssgproject.content_profile_standard; do
            if oscap info --profiles "${SSG_DIR}/${ssg}" | grep -qF "${profile}:"; then
              echo "Selected profile: ${profile}"
              break;
            fi
          done
 
          set +e
          oscap-docker image "${IMAGE_NAME}" xccdf eval --verbose ERROR --fetch-remote-resources --profile "${profile}" --results "openscap-report.xml" --report "openscap-report.html" "${SSG_DIR}/${ssg}"
          OSCAP_EXIT_CODE=$?
          set -e
 
          case "${OSCAP_EXIT_CODE}" in
            0)
              echo "All rules passed"
            ;;
            1)
              >&2 echo "An error occurred during evaluation"
              exit 2
            ;;
            2)
              echo "There is at least one rule with either fail or unknown result"
            ;;
            *)
              >&2 echo "openscap returned an unexpected exit status of $OSCAP_EXIT_CODE"
              exit "$OSCAP_EXIT_CODE"
            ;;
          esac