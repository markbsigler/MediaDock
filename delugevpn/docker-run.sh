#!/bin/sh
#
# https://hub.docker.com/r/binhex/arch-delugevpn/
#
#
# Description
#
# Deluge is a full-featured BitTorrent client for Linux, OS X, Unix and Windows. 
# It uses libtorrent in its backend and features multiple user-interfaces including: GTK+, web and console. 
# It has been designed using the client server model with a daemon process that handles all the bittorrent activity. 
# The Deluge daemon is able to run on headless machines with the user-interfaces being able to connect remotely from any platform. 
# This Docker includes OpenVPN to ensure a secure and private connection to the Internet, 
# including use of iptables to prevent IP leakage when the tunnel is down. 
# It also includes Privoxy to allow unfiltered access to index sites, 
# to use Privoxy please point your application at http://<host ip>:8118.
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

docker rm \
	--force \
	--volumes \
	delugevpn

docker image rm \
	binhex/arch-delugevpn

docker run \
	--detach \
	--name delugevpn \
	--hostname delugevpn \
	--cap-add=NET_ADMIN \
	--publish 8112:8112 \
	--publish 8118:8118 \
	--publish 58846:58846\
	--publish 58946:58946 \
	--volume /srv/share/container/delugevpn/config:/config \
	--volume /srv/share/downloads:/data \
	--volume /etc/localtime:/etc/localtime:ro \
	--env TZ=America/New_York \
	--env PGID=1000 \
	--env PUID=1000 \
	--env UMASK=002 \
	--restart unless-stopped \
	--network bridge_media \
	--env VPN_ENABLED=yes \
	--env VPN_USER=p3763775 \
	--env VPN_PASS=TGQs4q7e5N \
	--env VPN_PROV=pia \
	--env VPN_CLIENT=openvpn \
	--env STRICT_PORT_FORWARD=yes \
	--env ENABLE_PRIVOXY=yes \
	--env LAN_NETWORK=192.168.1.0/24 \
	--env NAME_SERVERS=209.222.18.222,84.200.69.80,37.235.1.174,1.1.1.1,209.222.18.218,37.235.1.177,84.200.70.40,1.0.0.1 \
	--env DELUGE_DAEMON_LOG_LEVEL=info \
	--env DELUGE_WEB_LOG_LEVEL=info \
	--env DELUGE_ENABLE_WEBUI_PASSWORD=yes \
	--env VPN_INPUT_PORTS=1234 \
	--env VPN_OUTPUT_PORTS=5678 \
	--env DEBUG=false \
	binhex/arch-delugevpn
