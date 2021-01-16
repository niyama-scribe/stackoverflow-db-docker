#!/bin/sh
rootDir="${1}"
sa_pwd="${2}"
sleep 60
for i in {1..3};
do
    /opt/mssql-tools/bin/sqlcmd -l 120 -S localhost -U sa -P "${sa_pwd}" -d master -i ${rootDir}/sql/setup.sql -v wkdir="${rootDir}/wkdir"
    if [ $? -eq 0 ]
    then
        echo "setup.sql completed"
        break
    else
        echo "not ready yet..."
        sleep 1
    fi
done