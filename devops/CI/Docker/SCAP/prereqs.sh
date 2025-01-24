set -eu
apk add curl docker openscap-docker npm gcompat unzip
npm install -g "@microsoft/sarif-multitool@${MICROSOFT_SARIF_MULTITOOL_VERSION}"
npm install -g "@mitre/saf@${MITRE_SAF_VERSION}"
mkdir -p "${SSG_DIR}"
curl "https://github.com/ComplianceAsCode/content/releases/download/v${SCAP_SECURITY_GUIDE_VERSION}/scap-security-guide-${SCAP_SECURITY_GUIDE_VERSION}.zip" -Lso "${SSG_DIR}/ssg.zip"
unzip "${SSG_DIR}/ssg.zip" -d "${SSG_DIR}"