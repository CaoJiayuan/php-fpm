FROM cjy632258/php-fpm-slim:nginx as base

COPY oracle-install.sh /
RUN chmod +x /oracle-install.sh && /oracle-install.sh

FROM cjy632258/php-fpm-slim:nginx 

COPY --from=base /opt/oracle/ /opt/oracle/

RUN apk add --no-cache --virtual .module-deps $PHPIZE_DEPS libtool \
    && apk add --no-cache libmcrypt-dev  \
    && pecl channel-update pecl.php.net \
    && pecl install mcrypt \
    && echo 'instantclient,/opt/oracle/instantclient_21_3' | pecl install oci8-2.2.0 \
    && docker-php-ext-enable oci8 \
    && docker-php-ext-enable mcrypt \
    && apk del .module-deps \
    && rm -fr /tmp/src \
    && rm -fr /var/cache/apk/*~