FROM cjy632258/php-fpm-slim:nginx

COPY instantclient-basic.zip /tmp
COPY instantclient-sdk.zip /tmp
COPY oracle-install.sh /tmp
RUN chmod +x /tmp/oracle-install.sh && /tmp/oracle-install.sh

ENV ORACLE_BASE /lib
ENV LD_LIBRARY_PATH /lib
ENV TNS_ADMIN /lib
ENV ORACLE_HOME /lib

RUN apk add --no-cache --virtual .module-deps $PHPIZE_DEPS libtool \
    && apk add --no-cache libmcrypt-dev  \
    && pecl channel-update pecl.php.net \
    && pecl install mcrypt \
    && echo 'instantclient,/lib' | pecl install oci8-2.2.0 \
    && docker-php-ext-enable oci8 \
    && docker-php-ext-enable mcrypt \
    && apk del .module-deps \
    && rm -fr /tmp/src \
    && rm -fr /var/cache/apk/*~