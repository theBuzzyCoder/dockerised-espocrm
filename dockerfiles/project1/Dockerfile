# Dockerfile

# Stage 1
FROM composer:1.7.2 as vendor

ARG VERSION

RUN apk add unzip \
    && wget -O /app/espocrm.zip https://github.com/espocrm/espocrm/archive/$VERSION.zip \
    && unzip -q -d / /app/espocrm.zip \
    && mv /espocrm-$VERSION/* /app \
    && composer install -o --ignore-platform-reqs

# Stage 2
FROM node:8.12.0-alpine as builder

ARG VERSION

COPY --from=vendor /app /espocrm

WORKDIR /espocrm

RUN npm install && npm install -g grunt-cli && grunt

# Stage 3
FROM nginx:alpine

LABEL MAINTAINER="@theBuzzyCoder"

ARG VERSION

COPY --from=builder --chown=nobody:nogroup /espocrm/build/EspoCRM-$VERSION /crm/espocrm
COPY --chown=nobody:nogroup ./projects/project1/application /crm/espocrm/custom
COPY --chown=nobody:nogroup ./projects/project1/client/custom /crm/espocrm/client/custom
COPY --chown=nobody:nogroup ./addons/PM-Extension/files /crm/espocrm
COPY ./etc/nginx/conf.d/espocrm.conf /etc/nginx/conf.d/default.conf

COPY ./dockerfiles/project1/entrypoint /usr/local/bin/entrypoint

WORKDIR /crm/espocrm

RUN apk add php7 php7-fpm php7-json curl php7-gd php7-pdo_mysql \
    php7-ldap php7-openssl php7-zip php7-session php7-mbstring php7-phar \
    php7-curl php7-xml php7-exif php7-iconv \
    && sed -i "s/max_execution_time = .*$/max_execution_time = 180/" /etc/php7/php.ini \
    && sed -i "s/max_input_time = .*$/max_input_time = 180/"   /etc/php7/php.ini  \
    && sed -i "s/memory_limit = .*$/memory_limit = 256M/" /etc/php7/php.ini \
    && sed -i "s/post_max_size = .*$/post_max_size = 50M/" /etc/php7/php.ini \
    && sed -i "s/upload_max_filesize = .*$/upload_max_filesize = 50M/" /etc/php7/php.ini \
    && wget -O phpunit https://phar.phpunit.de/phpunit-7.phar \
    && chmod +x phpunit \
    && chown -R nobody:nogroup data \
    && chown -R nobody:nogroup custom \
    && find data -type d -exec chmod 775 {} +;

ENTRYPOINT ["entrypoint"]

EXPOSE 80

CMD ["entrypoint"]
