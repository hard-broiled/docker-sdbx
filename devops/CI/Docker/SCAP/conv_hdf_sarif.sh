# shellcheck shell=sh
set -eu
DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 sarif-multitool convert -t Hdf -o openscap-report.sarif openscap-report.hdf.json