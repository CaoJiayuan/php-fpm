FROM php:7.1.10-fpm-alpine

ENV MONGO_VERSION=1.2.8 \
	MEMCACHED_VERSION=3.0.3
MAINTAINER 'Cao Jiayuan'
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --update --no-cache \
    icu-libs libpng libmcrypt libjpeg libcurl libintl libxml2 \
    freetype git libsasl libmemcached ca-certificates > /dev/null
RUN apk add --no-cache --virtual .module-deps \
    icu-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev \
    $PHPIZE_DEPS \
    openssl-dev libmemcached-dev zlib-dev curl-dev gettext-dev \
    libxml2-dev cyrus-sasl-dev > /dev/null && \

# Memcached
    mkdir -p /usr/src/php/ext && \
    wget -q http://pecl.php.net/get/memcached-${MEMCACHED_VERSION}.tgz && \
    tar -C /usr/src/php/ext -xf memcached-*.tgz && \
    rm memcached-*.tgz && \
    mv /usr/src/php/ext/memcached* /usr/src/php/ext/memcached && \

# MongoDB
    wget -q http://pecl.php.net/get/mongodb-${MONGO_VERSION}.tgz && \
    tar -C /usr/src/php/ext -xf mongo*.tgz && \
    rm mongo*.tgz && \
    mv /usr/src/php/ext/mongo* /usr/src/php/ext/mongodb && \

    docker-php-ext-install mcrypt gd intl mysqli pdo_mysql curl exif gettext mongodb xmlrpc zip bcmath memcached opcache && \
    apk del .module-deps && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/* && \

    php -r "copy('http://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"