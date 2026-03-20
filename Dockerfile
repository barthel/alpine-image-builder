FROM alpine:3.21

RUN apk add --no-cache \
    qemu-arm \
    qemu-aarch64 \
    parted \
    dosfstools \
    e2fsprogs \
    util-linux \
    multipath-tools \
    zip \
    unzip \
    wget \
    ca-certificates \
    file \
    shellcheck \
    ruby \
    && apk add --no-cache --virtual .build-deps \
        ruby-dev \
        build-base \
        linux-headers \
    && gem install serverspec --no-document \
    && apk del .build-deps
