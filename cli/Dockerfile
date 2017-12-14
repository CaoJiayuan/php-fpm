FROM php:7.2-cli-alpine3.6

WORKDIR /var/app
MAINTAINER 'Cao Jiayuan'
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --update --no-cache \
    tzdata icu-libs libpng libjpeg libcurl libxml2 \
    freetype ca-certificates
RUN apk add --no-cache --virtual .module-deps \
    icu-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev \
    $PHPIZE_DEPS \
    zlib-dev curl-dev gettext-dev \
    libxml2-dev libressl-dev postgresql-dev && \
    docker-php-ext-install pdo_pgsql mbstring gd mysqli pdo_mysql  curl exif gettext xmlrpc zip bcmath pcntl fileinfo && \
    apk del .module-deps && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*

## Superviser
ENV PYTHON_VERSION=2.7.13-r1
ENV PY_PIP_VERSION=9.0.1-r1
ENV SUPERVISOR_VERSION=3.3.1
RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION && \
    pip install supervisor==$SUPERVISOR_VERSION && mkdir -p /etc/supervisor && touch /etc/supervisor/default.conf && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*

COPY supervisord.conf /etc/supervisor/supervisord.conf

VOLUME /var/app

COPY ./run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT [ "/run.sh" ]