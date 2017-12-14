FROM php:7.2-cli-alpine

WORKDIR /var/app
MAINTAINER 'Cao Jiayuan'
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --update --no-cache \
    tzdata icu-libs libpng libjpeg libcurl libintl libxml2 postgresql-dev \
    freetype ca-certificates > /dev/null
RUN apk add --no-cache --virtual .module-deps \
    icu-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev \
    $PHPIZE_DEPS \
    openssl-dev zlib-dev curl-dev gettext-dev \
    libxml2-dev > /dev/null && \
    docker-php-ext-install mbstring gd intl mysqli pdo_mysql pdo_pgsql curl exif gettext xmlrpc zip bcmath pcntl fileinfo && \
    apk del .module-deps && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*

## Superviser
ENV PYTHON_VERSION=2.7.13-r1
ENV PY_PIP_VERSION=9.0.1-r1
ENV SUPERVISOR_VERSION=3.3.1
RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION && \
    pip install supervisor==$SUPERVISOR_VERSION && mkdir -p /etc/supervisor && touch /etc/supervisor/default.conf
COPY supervisord.conf /etc/supervisor/supervisord.conf

VOLUME /var/app

COPY ./run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT [ "/run.sh" ]