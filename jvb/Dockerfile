ARG JITSI_REPO=jitsi
ARG BASE_TAG=latest
FROM ${JITSI_REPO}/base-java:${BASE_TAG}

RUN apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get install -y jitsi-videobridge2 jq curl iproute2 dnsutils && \
    apt-cleanup

COPY rootfs/ /

RUN mkdir -pm775 /config && \
    chgrp -R 0 /config && \
    chmod -R g=u /config && \
    chgrp -R 0 /usr/share/jitsi-videobridge && \
    chmod -R g=u /usr/share/jitsi-videobridge
    chgrp -R 0 /defaults && \ 
    chmod -R g=u /defaults
    
VOLUME /config
