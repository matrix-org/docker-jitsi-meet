ARG JITSI_REPO=jitsi
ARG BASE_TAG=latest
FROM ${JITSI_REPO}/base-java:${BASE_TAG}

ADD jicofo_1.0-*autostream*.deb /tmp/jicofo-fosdem.deb
LABEL org.opencontainers.image.title="Jitsi Conference Focus (jicofo)"
LABEL org.opencontainers.image.description="Server-side focus component that manages media sessions and acts as load balancer."
LABEL org.opencontainers.image.url="https://github.com/jitsi/jicofo"
LABEL org.opencontainers.image.source="https://github.com/jitsi/docker-jitsi-meet"
LABEL org.opencontainers.image.documentation="https://jitsi.github.io/handbook/"

RUN apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get install -y jq ruby-hocon && \
    apt-dpkg-wrap dpkg -i /tmp/jicofo-fosdem.deb && \
    apt-cleanup

COPY rootfs/ /

VOLUME /config
