FROM php:7.2.5-fpm-alpine3.6

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add --no-cache --virtual .module-deps $PHPIZE_DEPS imagemagick-dev libtool \
    && apk add --no-cache --update ghostscript imagemagick \
    && pecl channel-update pecl.php.net \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del .module-deps \
    && rm -fr /tmp/src \
    && rm -fr /var/cache/apk/*