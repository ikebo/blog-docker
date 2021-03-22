FROM ubuntu:16.04
ENV CT="210319"

ENV http_proxy=http://172.22.132.118:1087

# 支持apt-get https
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates

# 换国内源
ADD ./sources.list /etc/apt/sources.list
ENV http_proxy=
RUN apt-get update

# 安装redis & common utils
RUN apt-get install -y redis-server redis-tools
RUN apt-get install -y software-properties-common
RUN apt-get update
RUN apt-get install -y iputils-ping net-tools telnet vim

# 使用本地http代理, 加速后面的repository下载
#ENV http_proxy=http://172.22.132.118:1087

# 安装MySQL
RUN apt-get install -y apt-utils \
    && { \
        echo debconf debconf/frontend select Noninteractive; \
        #echo mysql-community-server mysql-community-server/data-dir \
        #    select ''; \
        echo mysql-community-server mysql-community-server/root-pass \
            password 'mytest'; \
        echo mysql-community-server mysql-community-server/re-root-pass \
            password 'mytest'; \
        echo mysql-community-server mysql-community-server/remove-test-db \
            select true; \
    } | debconf-set-selections \ 
    && apt-get install -y mysql-server 

# 安装php php-fpm 在 /user/sbin 中
RUN apt-get install php -y
RUN apt-get install -y php-bcmath php-bz2 php-intl php-gd php-mbstring php-mcrypt php-mysql php-zip
RUN apt-get install -y php7.0-curl
RUN apt-get install -y libapache2-mod-php
RUN apt-get install -y php7.0-fpm

# fpm-conf & ini set error log loc
ADD ./php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
ADD ./php.ini /etc/php/7.0/fpm/php.ini

# 安装supervisor
RUN apt-get install -y supervisor

# 安装nginx
RUN apt-get install -y nginx
#ADD ./default /etc/nginx/sites-enabled/default
ADD ./blog.conf /root/blog.conf
ADD ./start.sh /root/start.sh
# 去掉代理，以免影响容器访问网络
ENV http_proxy=
ENV pwd=mytest

EXPOSE 80

CMD cp /root/blog.conf /etc/supervisor/conf.d/ && supervisord -n -c /etc/supervisor/supervisord.conf
