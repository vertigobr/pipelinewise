FROM python:3.7.4-buster

RUN apt-get -qq update && apt-get -qqy install \
        apt-utils \
        alien \
        libaio1 \
    && pip install --upgrade pip

# Oracle Instant Clinet for tap-oracle
RUN wget https://download.oracle.com/otn_software/linux/instantclient/193000/oracle-instantclient19.3-basiclite-19.3.0.0.0-1.x86_64.rpm -q -O /tmp/oracle-instantclient.rpm && \
    alien -i /tmp/oracle-instantclient.rpm --scripts && \
    rm -rf /tmp/oracle-instantclient.rpm

# Add non root user
RUN mkdir -p /app && \
    groupadd --system app && \
    useradd --system -g app -M -d /app app && \
    chown app:app /app

USER app
COPY . /app

RUN cd /app \
    && ./install.sh --connectors=all --acceptlicenses --nousage --notestextras
#RUN mkdir -p /root/.pipelinewise \
#    && ln -s /root/.pipelinewise /app/.pipelinewise

ENTRYPOINT ["/app/entrypoint.sh"]
