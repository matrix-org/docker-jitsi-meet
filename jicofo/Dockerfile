ARG JITSI_REPO=jitsi
ARG BASE_TAG=latest
FROM ${JITSI_REPO}/base-java:${BASE_TAG}

ADD jicofo_1.0-*autostream*.deb /tmp/jicofo-fosdem.deb
RUN apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get install -y jq ruby-hocon && \
    apt-dpkg-wrap dpkg -i /tmp/jicofo-fosdem.deb && \
    apt-cleanup

COPY rootfs/ /

VOLUME /config
