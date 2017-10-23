FROM php:7.1.10-fpm-alpine

WORKDIR /var/www
ENV MONGO_VERSION=1.2.8 \
	MEMCACHED_VERSION=3.0.3
MAINTAINER 'Cao Jiayuan'
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --update --no-cache \
    tzdata icu-libs libpng libmcrypt libjpeg libcurl libintl libxml2 \
    freetype git libsasl libmemcached ca-certificates > /dev/null
RUN apk add --no-cache --virtual .module-deps \
    icu-dev freetype-dev libjpeg-turbo-dev libmcrypt-dev libpng-dev \
    $PHPIZE_DEPS \
    openssl-dev libmemcached-dev zlib-dev curl-dev gettext-dev \
    libxml2-dev cyrus-sasl-dev > /dev/null && \
    mkdir -p /usr/src/php/ext && \
    wget -q http://pecl.php.net/get/memcached-${MEMCACHED_VERSION}.tgz && \
    tar -C /usr/src/php/ext -xf memcached-*.tgz && \
    rm memcached-*.tgz && \
    mv /usr/src/php/ext/memcached* /usr/src/php/ext/memcached && \
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
## Superviser
ENV PYTHON_VERSION=2.7.12-r0
ENV PY_PIP_VERSION=8.1.2-r0
ENV SUPERVISOR_VERSION=3.3.1
RUN apk update && apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION && \
    pip install supervisor==$SUPERVISOR_VERSION && mkdir -p /etc/supervisor && touch /etc/supervisor/default.conf
COPY supervisord.conf /etc/supervisor/supervisord.conf

COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY ./default.ini /usr/local/etc/php/conf.d/default.ini 
COPY ./run.sh /run.sh
RUN chmod +x /run.sh
CMD [ "/run.sh" ]