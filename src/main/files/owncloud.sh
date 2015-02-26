exec /usr/sbin/php5-fpm --nodaemonize --fpm-config /etc/php5/fpm/php-fpm.conf &
exec /usr/sbin/nginx -c /etc/nginx/nginx.conf
