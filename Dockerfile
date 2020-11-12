#
# Dockerfile for shadowsocks-libev and simple-obfs
#

FROM ctt828/rpi-arm32v6hf-alpine

ENV SERVER_ADDR           0.0.0.0
ENV SERVER_ADDR_IPV6      ::
ENV SERVER_PORT           8388
ENV PASSWORD              password
ENV METHOD                chacha20-ietf-poly1305
ENV TIMEOUT               300
ENV DNS_ADDRS             8.8.8.8,8.8.4.4
ENV OBFS_MODE             tls

RUN set -ex \
 # Build environment setup
 && apk add --no-cache --virtual .build-deps \
      autoconf \
      automake \
      build-base \
      c-ares-dev \
      libev-dev \
      libtool \
      libsodium-dev \
      linux-headers \
      mbedtls-dev \
      pcre-dev \
      xmlto \
      asciidoc \
      git \
 # Build & install shadowsocks-libev
 && git clone https://github.com/shadowsocks/shadowsocks-libev.git \
 && cd shadowsocks-libev \
 && git submodule update --init \
 && ./autogen.sh \
 && ./configure --prefix=/usr --disable-documentation \
 && make \
 && make install \
 && cd .. \
 # Build & install simple-obfs
 && git clone https://github.com/shadowsocks/simple-obfs.git \
 && cd simple-obfs \
 && git submodule update --init --recursive \
 && ./autogen.sh \
 && ./configure --disable-documentation \
 && make \
 && make install \
 && cd .. \
 # Runtime dependencies setup 
 && apk add --no-cache \
      rng-tools \
      $(scanelf --needed --nobanner /usr/bin/ss-* /usr/local/bin/obfs-* \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u) \
 # Clean up
 && apk del .build-deps \
 && rm -rf ./shadowsocks-libev \
 && rm -rf ./simple-obfs

CMD exec ss-server \
      -s $SERVER_ADDR \
      -s $SERVER_ADDR_IPV6 \
      -p $SERVER_PORT \
      -k $PASSWORD \
      -m $METHOD \
      -t $TIMEOUT \
      --fast-open \
      -d $DNS_ADDRS \
      -u \
      --plugin obfs-server \
      --plugin-opts "obfs=$OBFS_MODE;fast-open"
