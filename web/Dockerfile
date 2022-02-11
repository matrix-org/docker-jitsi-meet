ARG JITSI_REPO=jitsi
ARG BASE_TAG=latest
FROM ${JITSI_REPO}/base:${BASE_TAG}

ADD https://raw.githubusercontent.com/acmesh-official/acme.sh/2.8.8/acme.sh /opt
COPY rootfs/ /

RUN apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get install -y cron nginx-extras jitsi-meet-web socat && \
    apt-dpkg-wrap apt-get -d install -y jitsi-meet-web-config && \
    dpkg -x /var/cache/apt/archives/jitsi-meet-web-config*.deb /tmp/pkg && \
    mv /tmp/pkg/usr/share/jitsi-meet-web-config/config.js /defaults && \
    mv /usr/share/jitsi-meet/interface_config.js /defaults && \
    rm -f /etc/nginx/conf.d/default.conf && \
    apt-cleanup && \
    rm -rf /tmp/pkg /var/cache/apt && \
    mkdir -p \
    /config/{nginx/site-confs,keys} \
    /run \
    /var/lib/nginx/tmp/client_body \
    /var/tmp/nginx

RUN chgrp -R 0 /config && \
    chmod -R g=u /config &&
    chgrp -R 0 /usr/share/jitsi-meet && \
    chmod -R g=u /usr/share/jitsi-meet &&
    chgrp 0 /run && \
    chmod g=u 0 /run && \
    chgrp 0 /var/lib/nginx/tmp/client_body && \
    chmod -R g=u /var/lib/nginx/tmp/client_body && \
    chgrp 0 /var/tmp/nginx && \ 
    chmod -R g=u /var/tmp/nginx

EXPOSE 80 443

VOLUME ["/config", "/usr/share/jitsi-meet/transcripts"]
