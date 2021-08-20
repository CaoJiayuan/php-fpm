FROM cjy632258/php-fpm-slim:nginx as base

COPY oracle-install.sh /
RUN chmod +x /oracle-install.sh && /oracle-install.sh

FROM cjy632258/php-fpm-slim:nginx 

COPY --from=base /opt/oracle/ /opt/oracle/

RUN apk add --no-cache --virtual .module-deps $PHPIZE_DEPS libtool \
    && apk add --no-cache libaio libc6-compat libnsl \
    && ln -s /lib/libc.so.6 /usr/lib/libresolv.so.2 \
    && ln -s /lib64/ld-linux-x86-64.so.2 /usr/lib/ld-linux-x86-64.so.2 \
    && pecl channel-update pecl.php.net \
    && echo 'instantclient,/opt/oracle/instantclient_21_3' | pecl install oci8-2.2.0 \
    && docker-php-ext-enable oci8 \
    && apk del .module-deps \
    && rm -fr /tmp/src \
    && rm -fr /var/cache/apk/*~