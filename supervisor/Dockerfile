FROM php:7.3-fpm-alpine3.10

LABEL maintainer 'Cao Jiayuan'

## Superviser
ENV PYTHON_VERSION=2.7.18-r0
ENV PY_PIP_VERSION=18.1-r0
ENV SUPERVISOR_VERSION=3.3.5
RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION gettext && \
    pip install supervisor==$SUPERVISOR_VERSION && mkdir -p /etc/supervisor && touch /etc/supervisor/default.conf && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*

COPY supervisor-run.sh /supervisor-run.sh
RUN chmod +x /supervisor-run.sh
COPY ./supervisord.conf.template /etc/supervisor/supervisord.conf.template

ENTRYPOINT /supervisor-run.sh