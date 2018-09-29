#!/bin/sh
if [ -f "${CRONTAB_FILE}" ]; then
    cp ${CRONTAB_FILE} /etc/crontabs/root
fi

if [ "${TIMEZONE}" == "" ]; then
   TIMEZONE='Asia/Shanghai'
fi
if [ "${PM_MAX_CHILDREN}" == "" ]; then
   export PM_MAX_CHILDREN=5
fi

echo "date.timezone=${TIMEZONE}" >> /usr/local/etc/php/conf.d/default.ini && \
echo ${TIMEZONE} > /etc/timezone && \
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
envsubst '$PM_MAX_CHILDREN' < /usr/local/etc/php-fpm.d/www.conf.tempate > /usr/local/etc/php-fpm.d/www.conf

/usr/sbin/crond
/supervisor-run.sh