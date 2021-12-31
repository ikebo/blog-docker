#!/bin/bash
service php7.0-fpm start

chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
/etc/init.d/mysql start

#mysqldump -u root -p --all-databases > alldb.sql
mysqladmin -u root password $pwd
mysql -uroot -p$pwd < /var/www/html/db1.sql

chmod -R 777 /var/www/html/usr/uploads

cd /var/www/html
nohup python3 -u backer.py >back.log 2>&1 &

nginx -c /etc/nginx/nginx.conf
