FROM cjy632258/php-fpm-slim:nginx

RUN RUN apk add --no-cache --virtual .module-deps $PHPIZE_DEPS libtool \
    && pecl install grpc \
    && pecl install protobuf \
    && docker-php-ext-enable grpc protobuf \
    && apk del .module-deps \
    && rm -fr /tmp/src \
    && rm -fr /var/cache/apk/*