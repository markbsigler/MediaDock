#!/bin/sh

docker rm \
	--force \
	--volumes \
	radarr

docker image rm \
	linuxserver/radarr

docker run \
	--name radarr \
	--hostname radarr \
	--publish 7878:7878 \
	--volume /srv/share/container/radarr/config:/config \
	--volume /srv/share/media/videos/movies:/movies \
	--volume /srv/share/downloads:/downloads \
	--volume /etc/localtime:/etc/localtime:ro \
	--env TZ=America/New_York \
	--env PGID=1000 \
	--env PUID=1000 \
	--env UMASK=002 \
	--restart unless-stopped \
	--network bridge_media \
	--detach \
	linuxserver/radarr
