FROM debian:bookworm-slim

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    binfmt-support \
    qemu-user-static \
    parted \
    dosfstools \
    e2fsprogs \
    util-linux \
    kpartx \
    zip \
    unzip \
    wget \
    ca-certificates \
    file \
    shellcheck \
    ruby-full \
    build-essential \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && gem install serverspec --no-document
