#!/bin/bash
service php7.0-fpm start
/etc/init.d/mysql start

#mysqldump -u root -p --all-databases > alldb.sql
mysqladmin -u root password $pwd
mysql -uroot -p$pwd < /var/www/html/db.sql

nginx -c /etc/nginx/nginx.conf
