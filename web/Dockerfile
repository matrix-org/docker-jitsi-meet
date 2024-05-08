ARG JITSI_REPO=jitsi
ARG BASE_TAG=latest
FROM ${JITSI_REPO}/base:${BASE_TAG}

LABEL org.opencontainers.image.title="Jitsi Meet"
LABEL org.opencontainers.image.description="WebRTC compatible JavaScript application that uses Jitsi Videobridge to provide high quality, scalable video conferences."
LABEL org.opencontainers.image.url="https://jitsi.org/jitsi-meet/"
LABEL org.opencontainers.image.source="https://github.com/jitsi/docker-jitsi-meet"
LABEL org.opencontainers.image.documentation="https://jitsi.github.io/handbook/"

ADD https://raw.githubusercontent.com/acmesh-official/acme.sh/3.0.7/acme.sh /opt
COPY rootfs/ /

RUN apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get install -y dnsutils cron nginx-extras jitsi-meet-web socat curl jq bash && \
    mv /usr/share/jitsi-meet/interface_config.js /defaults && \
    rm -f /etc/nginx/conf.d/default.conf && \
    apt-cleanup

# doesn't exist at build time
RUN mkdir -pv /config/nginx/site-confs && \
    mkdir -pv /config/keys && \
    mkdir -pv /var/lib/nginx/tmp/client_body

RUN chgrp -R 0 /config && \
    chmod -R g=u /config && \
    chgrp -R 0 /usr/share/jitsi-meet && \
    chmod -R g=u /usr/share/jitsi-meet && \
    chgrp 0 /run && \
    chmod g=u /run && \
    chgrp 0 /var/lib/nginx/tmp/client_body && \
    chmod -R g=u /var/lib/nginx/tmp/client_body && \
    chgrp -R 0 /var/log/nginx && \
    chmod -R g=u /var/log/nginx && \
    chgrp -R 0 /var/lib/nginx && \
    chmod -R g=u /var/lib/nginx

EXPOSE 80 443
ENTRYPOINT ["/entrypoint"]

VOLUME ["/config", "/usr/share/jitsi-meet/transcripts"]
