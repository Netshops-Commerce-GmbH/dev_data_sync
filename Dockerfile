FROM ubuntu:latest

ENV TERM=linux

RUN apt-get update \
    && apt-get -y --no-install-recommends install inotify-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*;

VOLUME ["/var/www/src", "/var/www/html"]

ADD entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

CMD /root/entrypoint.sh

WORKDIR /var/www/src