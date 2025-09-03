#!/bin/sh

docker rm \
    --force \
    --volumes \
    nzbgetvpn

docker image rm \
    jshridha/docker-nzbgetvpn:latest

docker run \
    --detach \
    --name nzbgetvpn \
    --hostname nzbgetvpn \
    --cap-add=NET_ADMIN \
    --publish 8112:8112 \
    --publish 8118:8118 \
    --publish 58846:58846 
    --publish 58946:58946 \
    --volume /srv/share/container/nzbgetvpn/config:/config \
    --volume /srv/share/downloads:/data \
    --volume /etc/localtime:/etc/localtime:ro \
    --env TZ=America/New_York \
    --env PGID=1000 \
    --env PUID=1000 \
    --env UMASK=002 \
    --restart unless-stopped \
    --network bridge_media \
    --env VPN_ENABLED=yes \
    --env VPN_USER=REMOVED_UID \
    --env VPN_PASS=REMOVED_PWD \
    --env VPN_PROV=pia \
    --env VPN_CLIENT=openvpn \
    --env STRICT_PORT_FORWARD=yes \
    --env ENABLE_PRIVOXY=yes \
    --env LAN_NETWORK=192.168.1.0/24 \
    --env NAME_SERVERS=209.222.18.222,84.200.69.80,37.235.1.174,1.1.1.1,209.222.18.218,37.235.1.177,84.200.70.40,1.0.0.1 \
    --env VPN_INPUT_PORTS=1234 \
    --env VPN_OUTPUT_PORTS=5678 \
    --env DEBUG=false \
    jshridha/docker-nzbgetvpn:latest

#
# Notes
#
# Please note this Docker image does not include the required OpenVPN configuration file and certificates.
# These will typically be downloaded from your VPN providers website (look for OpenVPN configuration files), and generally are zipped.
#
# PIA users - The URL to download the OpenVPN configuration files and certs is:-
#
# https://www.privateinternetaccess.com/openvpn/openvpn.zip
#
# Once you have downloaded the zip (normally a zip as they contain multiple ovpn files)
# then extract it to /config/openvpn/ folder
# (if that folder doesn't exist then start and stop the docker container to force the creation of the folder).
#
# If there are multiple ovpn files then please delete the ones you don't want to use
# (normally filename follows location of the endpoint) leaving just a single ovpn file
# and the certificates referenced in the ovpn file (certificates will normally have a crt and/or pem extension).
#
