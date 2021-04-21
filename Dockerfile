FROM cjy632258/php-fpm-slim:supervisor

WORKDIR /var/www

LABEL maintainer 'Cao Jiayuan'

ENV TIMEZONE=Asia/Shanghai \
    PM_MAX_CHILDREN=32 \
    FPM_LISTEN=127.0.0.1:9000

RUN apk add --update --no-cache \
    gettext tzdata icu-libs libzip libpng libjpeg libjpeg-turbo-dev libpng-dev libcurl libintl libxml2 postgresql-dev \
    freetype ca-certificates > /dev/null
RUN apk add --no-cache --virtual .module-deps \
    icu-dev libzip-dev freetype-dev libmcrypt-dev \
    $PHPIZE_DEPS \
    zlib-dev curl-dev gettext-dev \
    libxml2-dev libressl-dev > /dev/null && \
    docker-php-ext-configure gd --with-jpeg --with-freetype && \
    NUMPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    docker-php-ext-install -j${NUMPROC} pdo_pgsql gd zip intl pdo_mysql curl exif gettext xmlrpc bcmath opcache pcntl && \
    apk del .module-deps && \
    rm -fr /tmp/src && \
    rm -fr /var/cache/apk/*

COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY ./default.ini /usr/local/etc/php/conf.d/default.ini 
COPY ./www.conf.template /usr/local/etc/www.conf.tempate
COPY ./run.sh /run.sh
RUN chmod +x /run.sh
ENTRYPOINT /run.sh