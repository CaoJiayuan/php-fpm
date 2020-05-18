#!/bin/sh
if [ -f "${SUPERVISOR_CONF}" ]; then
    cp ${SUPERVISOR_CONF} /etc/supervisor/default.conf
fi

envsubst '$SUPERVISOR_CONFIG_DIR' < /etc/supervisor/supervisord.conf.template > /etc/supervisor/supervisord.conf
supervisord --configuration /etc/supervisor/supervisord.conf
php-fpm