#!/bin/sh

docker rm \
	--force \
	--volumes \
	sonarr

docker image rm \
	linuxserver/sonarr

docker run \
	--name sonarr \
	--hostname sonarr \
	--publish 8989:8989 \
	--volume /srv/share/container/sonarr/config:/config \
	--volume /srv/share/media/videos/tv:/tv \
	--volume /srv/share/downloads:/downloads \
	--volume /etc/localtime:/etc/localtime:ro \
	--env TZ=America/New_York \
	--env PGID=1000 \
	--env PUID=1000 \
	--env UMASK=002 \
	--restart unless-stopped \
	--network bridge_media \
	--detach \
	linuxserver/sonarr
