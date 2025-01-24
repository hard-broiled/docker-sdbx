# shellcheck shell=sh
set -eu
saf convert xccdf_results2hdf -i "openscap-report.xml" -o openscap-report.hdf