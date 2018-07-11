FROM php:7.1-fpm-alpine
RUN apk add php7-fpm curl
RUN apk add php7-curl php7-mysqli php7-json php7-gd php7-pdo_mysql php7-imap php7-mbstring php7-soap php7-mcrypt

COPY --chown=www-data:www-data ./EspoCRM-5.3.0 /var/www/html
RUN chmod -R 775 /var/www/html/data
