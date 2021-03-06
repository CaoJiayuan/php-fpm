#!/bin/sh

if [ -f "${SUPERVISOR_CONF}" ]; then
    cp ${SUPERVISOR_CONF} /etc/supervisor/default.conf
fi
if [ -f "${CRONTAB_FILE}" ]; then
    cp ${CRONTAB_FILE} /etc/crontabs/root
fi

if [ "${TIMEZONE}" == "" ]; then
   TIMEZONE='Asia/Shanghai'
fi

echo ${TIMEZONE} > /etc/timezone && \
ln -sf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

supervisord --configuration /etc/supervisor/supervisord.conf
/usr/sbin/crond