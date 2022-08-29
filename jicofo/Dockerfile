ARG JITSI_REPO=jitsi
ARG BASE_TAG=latest
FROM ${JITSI_REPO}/base-java:${BASE_TAG}

LABEL org.opencontainers.image.title="Jitsi Conference Focus (jicofo)"
LABEL org.opencontainers.image.description="Server-side focus component that manages media sessions and acts as load balancer."
LABEL org.opencontainers.image.url="https://github.com/jitsi/jicofo"
LABEL org.opencontainers.image.source="https://github.com/jitsi/docker-jitsi-meet"
LABEL org.opencontainers.image.documentation="https://jitsi.github.io/handbook/"

RUN apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get install -y jicofo && \
    apt-cleanup

COPY rootfs/ /

RUN mkdir -pm775 /config && \
    chgrp -R 0 /config && \
    chmod -R g=u /config && \
    chgrp -R 0 /usr/share/jicofo && \
    chmod -R g=u /usr/share/jicofo && \
    chgrp 0 /etc && \
    chmod g=u /etc
     
VOLUME /config
