# Dockerfile

# Official php:7.2-fpm-alpine image
# Docker Hub: https://hub.docker.com/r/_/php
FROM php:7.2-fpm-alpine as builder

LABEL MAINTAINER "@theBuzzyCoder"

RUN apk update \
    && apk add autoconf file g++ gcc libc-dev make pkgconf re2c \
        freetype-dev libjpeg-turbo-dev libpng-dev libzip imap-dev openldap-dev \
        nodejs npm \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo_mysql zip imap exif ldap

RUN pecl install mailparse && docker-php-ext-enable mailparse

RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    cp composer.phar /usr/local/bin/composer

COPY ./espocrm /var/www/html/espocrm
WORKDIR /var/www/html/espocrm

RUN composer install -o && npm install -g grunt && npm install
RUN grunt less


FROM php:7.2-fpm-alpine
RUN apk update && apk add \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN apk add libzip && docker-php-ext-install zip exif pdo_mysql

COPY --from=builder /var/www/html/espocrm /var/www/html/espocrm

WORKDIR /var/www/html/espocrm

RUN find data -type d -exec chmod 775 {} + && chown -R 82:82 . \
    && cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini \
    && sed -i "s/max_execution_time = .*$/max_execution_time = 180/" /usr/local/etc/php/php.ini \
    && sed -i "s/max_input_time = .*$/max_input_time = 180/"   /usr/local/etc/php/php.ini  \
    && sed -i "s/memory_limit = .*$/memory_limit = 256M/" /usr/local/etc/php/php.ini \
    && sed -i "s/post_max_size = .*$/post_max_size = 50M/" /usr/local/etc/php/php.ini \
    && sed -i "s/upload_max_filesize = .*$/upload_max_filesize = 50M/" /usr/local/etc/php/php.ini

ENTRYPOINT ["docker-php-entrypoint"]

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]
