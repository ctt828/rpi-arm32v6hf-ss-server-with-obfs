[![Build Status](https://travis-ci.org/ctt828/shadowsocks-libev-arm32v6hf.svg?branch=master)](https://travis-ci.org/ctt828/shadowsocks-libev-arm32v6hf)

# shadowsocks-libev-arm32v6hf
Starts a shadowsocks-libev server with simple-obfs enabled on Raspberry Pi 1 (arm32v6hf).

By default, AEAD encryption chacha20-ietf-poly1305, TLS obfuscation, IPv6, TCP fast open, UDP relay, Google DNS are enabled :

$ docker run -d --restart=always --name=ss-server -e PASSWORD=password -p 443:8388 -p 443:8388/udp ctt828/shadowsocks-libev-arm32v6hf

https://github.com/shadowsocks/shadowsocks-libev

https://github.com/shadowsocks/simple-obfs
