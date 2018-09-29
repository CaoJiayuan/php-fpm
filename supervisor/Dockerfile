FROM php:7.2.8-fpm-alpine3.6

MAINTAINER 'Cao Jiayuan'

## Superviser
ENV PYTHON_VERSION=2.7.15-r0
ENV PY_PIP_VERSION=9.0.1-r1
ENV SUPERVISOR_VERSION=3.3.4
RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION && \
    pip install supervisor==$SUPERVISOR_VERSION && mkdir -p /etc/supervisor && touch /etc/supervisor/default.conf && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*

COPY supervisor-run.sh /supervisor-run.sh
RUN chmod +x /supervisor-run.sh
COPY supervisord.conf /etc/supervisor/supervisord.conf

ENTRYPOINT /supervisor-run.sh