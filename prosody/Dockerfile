ARG JITSI_REPO=jitsi
ARG BASE_TAG=latest

FROM ${JITSI_REPO}/base:${BASE_TAG} as builder

RUN apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get install -y \
      lua5.2 \
      liblua5.2-dev \
      libssl-dev \
      luarocks \
      git \
      gcc && \
    luarocks install net-url 0.9-1 && \
    luarocks install luajwtjitsi 2.0-0

FROM ${JITSI_REPO}/base:${BASE_TAG}

ENV XMPP_CROSS_DOMAIN="false"
ARG UVS_TAG=v1.7.0

RUN wget -qO /etc/apt/trusted.gpg.d/prosody.gpg https://prosody.im/files/prosody-debian-packages.key && \
    echo "deb http://packages.prosody.im/debian bullseye main" > /etc/apt/sources.list.d/prosody.list && \
    apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get install -y \
      prosody \
      libssl1.1 \
      libldap-common \
      sasl2-bin \
      libsasl2-modules-ldap \
      lua-basexx \
      lua-ldap \
      lua-http \
      lua-cyrussasl \
      lua-sec \
      patch && \
    apt-cleanup && \
    rm -rf /etc/prosody && \
    apt-dpkg-wrap apt-get update && \
    apt-dpkg-wrap apt-get -d install -y jitsi-meet-prosody && \
    dpkg -x /var/cache/apt/archives/jitsi-meet-prosody*.deb /tmp/pkg && \
    mv /tmp/pkg/usr/share/jitsi-meet/prosody-plugins /prosody-plugins && \
    apt-cleanup && \
    rm -rf /tmp/pkg /var/cache/apt && \
    patch -d /usr/lib/prosody/modules/muc -p0 < /prosody-plugins/muc_owner_allow_kick.patch
ADD https://raw.githubusercontent.com/matrix-org/prosody-mod-auth-matrix-user-verification/${UVS_TAG}/mod_auth_matrix_user_verification.lua \
    https://raw.githubusercontent.com/matrix-org/prosody-mod-auth-matrix-user-verification/${UVS_TAG}/mod_matrix_power_sync.lua \
    /prosody-plugins/

COPY rootfs/ /

COPY --from=builder /usr/local/lib/lua /usr/local/lib/lua
COPY --from=builder /usr/local/share/lua /usr/local/share/lua

# These permissions changes / directory paths allow the container to run as non-root
RUN chgrp 0 /var && \
    chgrp 0 /var/run && \
    chmod g=u /var && \
    chmod g=u /var/run && \
    mkdir -pm777 /var/run/saslauthd && \
    chgrp -R 0 /var/run/saslauthd && \
    chmod -R g=u /var/run/saslauthd && \
    chgrp -R 0 /defaults && \
    chmod -R g=u /defaults && \
    mkdir /config && \
    mkdir /config/data && \
    mkdir /config/certs && \
    chgrp -R 0 /config && \
    chmod -R g=u /config && \
    chgrp 0 /etc/localtime && \
    chmod g=u /etc/localtime && \
    chgrp 0 /etc && \
    chmod g=u /etc && \
    chgrp -R 0 /etc/ldap && \
    chmod -R g=u /etc/ldap


EXPOSE 5222 5347 5280

VOLUME ["/config", "/prosody-plugins-custom"]
