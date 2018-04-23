FROM alpine:latest

ENV TERM=xterm-256color \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_CTYPE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    TIMEZONE=Asia/Shanghai

WORKDIR /root

VOLUME /root

COPY ./install.sh .
COPY ./launch.sh /usr/local/bin/launch.sh

RUN chmod +x ./install.sh
RUN chmod +x /usr/local/bin/launch.sh
RUN ./install.sh

ENTRYPOINT ["launch.sh"]
