FROM mcr.microsoft.com/mssql/server:2019-latest

# Switch to root user
USER root

#Install required dependencies
RUN apt-get -y update  && \
        apt-get install --no-install-recommends -y dos2unix p7zip-full && \
        rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/so-db
COPY ./src/main/. /opt/so-db/
RUN find /opt/so-db/bin/ -type f -print0 | xargs -0 dos2unix && \
    find /opt/so-db/bin/ -type f -print0 | xargs -0 chmod +x && \
    mkdir -p /opt/so-db/wkdir

COPY --from=niyamascribe/stackoverflow-data:0.1.0 /opt/so-data/StackOverflow2010.7z /opt/so-db/wkdir/

RUN chown mssql: /opt/so-db/wkdir && \
    chmod 0744 /opt/so-db/wkdir

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=N3v3r!nPr0d
ENV MSSQL_PID=Developer

# Switch back to mssql user
USER mssql

ENTRYPOINT /bin/bash /opt/so-db/bin/entrypoint.sh $SA_PASSWORD
#ENTRYPOINT /opt/mssql/bin/sqlservr

