#!/bin/sh

docker rm \
	--force \
	--volumes \
	beets

docker run \
	--name beets \
	--hostname beets \
	--publish 8337:8337 \
	--volume beets_data:/config \
	--volume /srv/share/media/music:/music \
	--volume /srv/share/downloads:/downloads \
	--volume /etc/localtime:/etc/localtime:ro \
	--env TZ=America/New_York \
	--env PGID=1000 \
	--env PUID=1000 \
	--env UMASK=002 \
	--restart unless-stopped \
	--network bridge_all \
	--detach \
	linuxserver/beets
