FROM alpine:3.9

ENV TERM=linux

RUN apk add --no-cache lsyncd
VOLUME ["/var/www/src", "/var/www/html"]

ADD lsyncd.conf /lsyncd.conf
ADD wait-for-datacontainer.sh /wait-for-datacontainer.sh
RUN chmod +x /wait-for-datacontainer.sh

CMD /wait-for-datacontainer.sh "lsyncd -nodaemon -log scarce /lsyncd.conf"
WORKDIR /var/www/src