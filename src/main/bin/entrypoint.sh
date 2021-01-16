#!/bin/sh

set -o errexit
set -o pipefail
set -o nounset
#set -o xtrace

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"
__root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app

password="${1}"

if [ ! -f /opt/so-db/wkdir/StackOverflow2010.mdf ]; then
    echo "Need to extract data files from archive"

    # Unzip data 
    7z e /opt/so-db/wkdir/StackOverflow2010.7z -o/opt/so-db/wkdir
    rm /opt/so-db/wkdir/StackOverflow2010.7z
fi

.${__dir}/import-data.sh "${__root}" "${password}" &
/opt/mssql/bin/sqlservr

#echo "Server is ready now."