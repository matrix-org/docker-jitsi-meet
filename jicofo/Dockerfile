ARG JITSI_REPO=jitsi
ARG BASE_TAG=latest
FROM ${JITSI_REPO}/base-java:${BASE_TAG}

RUN apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get install -y jicofo && \
    apt-cleanup

COPY rootfs/ /

RUN chgrp -R 0 /config && \
    chmod -R g=u /config &&
    chgrp -R 0 /usr/share/jicofo && \
    chmod -R g=u /usr/share/jicofo
     
VOLUME /config
