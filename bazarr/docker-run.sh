#!/bin/sh

docker rm \
	--force \
	--volumes \
	bazarr

docker image rm \
	linuxserver/bazarr

docker run \
	--name bazarr \
	--hostname bazarr \
	--publish 6767:6767/tcp \
	--volume /srv/share/container/bazarr/config:/config \
	--volume /srv/share/media/videos/movies:/movies \
	--volume /srv/share/media/videos/tv:/tv \
	--volume /etc/localtime:/etc/localtime:ro \
	--env TZ=America/New_York \
	--env PGID=1000 \
	--env PUID=1000 \
	--env UMASK=002 \
	--restart unless-stopped \
	--network bridge_media \
	--detach \
	linuxserver/bazarr
