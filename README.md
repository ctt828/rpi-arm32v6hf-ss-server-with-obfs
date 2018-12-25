# rpi-ss-server-with-obfs
Starts a shadowsocks-libev server with simple-obfs enabled on RPi (armhf).

By default, AEAD encryption chacha20-ietf-poly1305, TLS obfuscation, IPv6, TCP fast open, UDP relay, Google DNS are enabled :

$ docker run -d --restart=always --name=ss-server -e PASSWORD=password -p 443:8388 -p 443:8388/udp ctt828/rpi-ss-server-with-obfs

https://github.com/shadowsocks/shadowsocks-libev

https://github.com/shadowsocks/simple-obfs
