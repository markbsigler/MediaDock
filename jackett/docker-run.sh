#!/bin/sh

docker rm \
	--force \
	--volumes \
	jackett

docker image rm \
	linuxserver/jackett

docker run \
	--name jackett \
	--hostname jackett \
	--publish 9117:9117 \
	--volume /srv/share/container/jackett/config:/config \
	--volume /srv/share/downloads:/downloads \
	--volume /etc/localtime:/etc/localtime:ro \
	--env TZ=America/New_York \
	--env PGID=1000 \
	--env PUID=1000 \
	--env UMASK=002 \
	--restart unless-stopped \
	--network bridge_media \
	--detach \
	linuxserver/jackett
