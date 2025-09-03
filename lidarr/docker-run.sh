#!/bin/sh

docker rm \
	--force \
	--volumes \
	lidarr

docker image rm \
	linuxserver/lidarr

docker run \
	--name lidarr \
	--hostname lidarr \
	--publish 8686:8686 \
	--volume /srv/share/container/lidarr/config:/config \
	--volume /srv/share/media/music:/music \
	--volume /srv/share/downloads:/downloads \
	--volume /etc/localtime:/etc/localtime:ro \
	--env TZ=America/New_York \
	--env PGID=1000 \
	--env PUID=1000 \
	--env UMASK=002 \
	--restart unless-stopped \
	--network bridge_media \
	--detach \
	linuxserver/lidarr
