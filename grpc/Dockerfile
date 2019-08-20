FROM cjy632258/php-fpm-slim:nginx

RUN pecl install grpc \
    && pecl install protobuf \
    && docker-php-ext-enable grpc protobuf