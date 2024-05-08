FROM docker.io/library/debian:bookworm-slim

ENV DEBIAN_FRONTEND noninteractive

ARG JITSI_RELEASE=stable
COPY rootfs /

RUN \
    dpkgArch="$(dpkg --print-architecture)" && \
    case "${dpkgArch##*-}" in \
        "amd64") TPL_ARCH=amd64; S6_ARCH=amd64 ;; \
        "arm64") TPL_ARCH=arm64; S6_ARCH=aarch64 ;; \
        *) echo "unsupported architecture"; exit 1 ;; \
    esac && \
    apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get install -y apt-transport-https apt-utils ca-certificates gnupg wget && \
    wget -qO /usr/bin/tpl https://github.com/jitsi/tpl/releases/download/v1.1.1/tpl-linux-${TPL_ARCH} && \
    wget -qO - https://download.jitsi.org/jitsi-key.gpg.key | gpg --dearmour > /etc/apt/trusted.gpg.d/jitsi.gpg && \
    echo "deb https://download.jitsi.org $JITSI_RELEASE/" > /etc/apt/sources.list.d/jitsi.list && \
    echo "deb http://ftp.debian.org/debian bookworm-backports main" > /etc/apt/sources.list.d/backports.list && \
    apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get dist-upgrade -y && \
    apt-cleanup && \
    chmod +x /usr/bin/tpl

RUN [ "$JITSI_RELEASE" = "unstable" ] && \
    apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get install -y jq procps curl vim iputils-ping net-tools && \
    apt-cleanup || \
    true

# supervisor installation &&
# create directory for child images to store configuration in
RUN apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get -y install supervisor && \
    mkdir -p /var/log/supervisor

# fix permissions for timezone initialization
RUN chgrp -R 0 /usr/share/zoneinfo && \
    chgrp 0 /etc && \
    chgrp 0 /etc/localtime && \
    chgrp 0 /etc/timezone && \
    chgrp 0 /var/run && \
    chgrp 0 /var/log && \
    chmod g=u /var/run && \
    chmod g=u /var/log && \
    chmod g=u /etc && \
    chmod g=u /etc/localtime && \
    chmod g=u /etc/timezone && \
    chmod -R g=u /usr/share/zoneinfo

CMD [ "supervisord",  "-c", "/etc/supervisor.conf" ]
ENTRYPOINT [ "/entrypoint" ]
