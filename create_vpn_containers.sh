#!/bin/bash

read -p "Number of VPN containers to create: " amount 
for ((i = 0; i <= $amount; i++)); do
    docker run -dit \
    --name=awg$i \
    --privileged \
    -v /etc/amnezia/amneziawg/multi_$i/:/config \
    --device=/dev/net/tun:/dev/net/tun \
    --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
    --sysctl="net.ipv4.ip_forward=1" \
    --cap-add=NET_ADMIN \
    --cap-add=SYS_MODULE \
    --restart always \
    ghcr.io/zeozeozeo/amneziawg-client
done
