FROM php:7.2.5-fpm-alpine3.6

WORKDIR /var/www

MAINTAINER 'Cao Jiayuan'
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --update --no-cache \
    gettext tzdata icu-libs libzip libpng libjpeg libjpeg-turbo-dev libpng-dev libcurl libintl libxml2 \
    freetype ca-certificates > /dev/null
RUN apk add --no-cache --virtual .module-deps \
    icu-dev libzip-dev freetype-dev libmcrypt-dev \
    $PHPIZE_DEPS \
    zlib-dev curl-dev gettext-dev \
    libxml2-dev libressl-dev > /dev/null && \
    docker-php-ext-install zip intl pdo_mysql curl exif gettext xmlrpc bcmath opcache pcntl && \
    docker-php-ext-install gd --with-jpeg-dir=/usr/lib/ --with-freetype-dir=/usr/lib/ --with-png-dir=/usr/lib/ --with-gd && \
    apk del .module-deps && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*
## Superviser
ENV PYTHON_VERSION=2.7.14-r0
ENV PY_PIP_VERSION=9.0.1-r1
ENV SUPERVISOR_VERSION=3.3.1
RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION && \
    pip install supervisor==$SUPERVISOR_VERSION && mkdir -p /etc/supervisor && touch /etc/supervisor/default.conf && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*

COPY supervisord.conf /etc/supervisor/supervisord.conf

COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY ./default.ini /usr/local/etc/php/conf.d/default.ini 
COPY ./www.conf.template /usr/local/etc/php-fpm.d/www.conf.tempate
COPY ./run.sh /run.sh
RUN chmod +x /run.sh
CMD [ "/run.sh" ]