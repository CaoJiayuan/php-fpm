FROM php:7-fpm-alpine

LABEL maintainer 'Cao Jiayuan'

## Superviser
RUN apk update && apk add -u --no-cache supervisor && \
    mkdir -p /etc/supervisor && touch /etc/supervisor/default.conf && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*

COPY supervisor-run.sh /supervisor-run.sh
RUN chmod +x /supervisor-run.sh
COPY ./supervisord.conf.template /etc/supervisor/supervisord.conf.template


ENTRYPOINT /supervisor-run.sh