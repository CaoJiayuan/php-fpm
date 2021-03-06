FROM php:7.3-cli-alpine3.10

WORKDIR /var/app
LABEL maintainer 'Cao Jiayuan'

LABEL maintainer 'Cao Jiayuan'

## Superviser
ENV PYTHON_VERSION=2.7.16-r1
ENV PY_PIP_VERSION=18.1-r0
ENV SUPERVISOR_VERSION=3.3.5

RUN apk add --update --no-cache \
    tzdata icu-libs libpng libjpeg libcurl libintl libxml2 \
    freetype ca-certificates
RUN apk add --no-cache --virtual .module-deps \
    icu-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev \
    $PHPIZE_DEPS \
    zlib-dev curl-dev gettext-dev \
    libxml2-dev libressl-dev  && \
    docker-php-ext-install mbstring gd pdo_mysql curl exif gettext xmlrpc bcmath pcntl && \
    apk del .module-deps && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*

## Superviser
RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION && \
    pip install supervisor==$SUPERVISOR_VERSION && mkdir -p /etc/supervisor && touch /etc/supervisor/default.conf && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*

COPY supervisord.conf /etc/supervisor/supervisord.conf

COPY ./run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT [ "/run.sh" ]