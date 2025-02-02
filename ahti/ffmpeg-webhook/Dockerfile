FROM alpine:latest
EXPOSE 9000/tcp
WORKDIR /app
COPY ./*.sh .
COPY ./hooks.yaml .
RUN dos2unix ./* \
    && chmod +x ./*.sh \
    && apk add ffmpeg jq webhook
ENTRYPOINT [ "webhook", "-hooks", "/app/hooks.yaml", "-verbose" ]
