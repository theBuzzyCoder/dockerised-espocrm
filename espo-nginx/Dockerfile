FROM nginx:alpine
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.template.conf

COPY ./espocrm /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/app.conf
