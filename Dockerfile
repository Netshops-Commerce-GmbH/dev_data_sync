FROM alpine:3.9

ENV TERM=linux

RUN apk add --no-cache lsyncd
VOLUME ["/var/www/src", "/var/www/html"]

CMD lsyncd -nodaemon -log scarce -direct /var/www/src /var/www/html
WORKDIR /var/www/src