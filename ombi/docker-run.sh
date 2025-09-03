#!/bin/sh

docker rm \
	--force \
	--volumes \
	ombi

docker image rm \
	linuxserver/ombi

docker run \
	--name ombi \
	--hostname ombi \
	--publish 3579:3579 \
	--volume /srv/share/container/ombi/config:/config \
	--volume /etc/localtime:/etc/localtime:ro \
	--env TZ=America/New_York \
	--env PGID=1000 \
	--env PUID=1000 \
	--env UMASK=002 \
	--restart unless-stopped \
	--network bridge_media \
	--detach \
	linuxserver/ombi
