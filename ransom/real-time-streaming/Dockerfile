FROM alpine:latest
RUN apk update && apk add --no-cache ffmpeg supervisor
COPY ./supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
