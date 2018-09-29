#!/bin/sh
if [ -f "${SUPERVISOR_CONF}" ]; then
    cp ${SUPERVISOR_CONF} /etc/supervisor/default.conf
fi

supervisord --configuration /etc/supervisor/supervisord.conf
php-fpm