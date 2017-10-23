if [ -f "${SUPERVISOR_CONF}" ]; then
    cp ${SUPERVISOR_CONF} /etc/supervisor/default.conf
fi
if [ -f "${CRONTAB_FILE}" ]; then
    cp ${CRONTAB_FILE} /etc/crontabs/root
fi

supervisord --configuration /etc/supervisor/supervisord.conf
/usr/sbin/crond
php-fpm