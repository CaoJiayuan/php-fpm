#!/bin/sh
if [ -f "${CRONTAB_FILE}" ]; then
    cp ${CRONTAB_FILE} /etc/crontabs/root
fi

echo 'clear conf'
rm -fr /usr/local/etc/php-fpm.d/*

echo "date.timezone=${TIMEZONE}" >> /usr/local/etc/php/conf.d/default.ini && \
echo ${TIMEZONE} > /etc/timezone && \
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
envsubst '$PM_MAX_CHILDREN,$FPM_LISTEN' < /usr/local/etc/www.conf.tempate > /usr/local/etc/php-fpm.d/www.conf

/usr/sbin/crond
/supervisor-run.sh