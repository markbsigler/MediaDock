#!/bin/sh

docker rm \
	--force \
	--volumes \
	tautulli

docker image rm \
	linuxserver/tautulli

docker run \
	--name=tautulli \
	--hostname tautulli \
	--publish 8181:8181 \
	--volume /srv/share/container/tautulli/config:/config \
	--volume /etc/localtime:/etc/localtime:ro \
	--env TZ=America/New_York \
	--env PGID=1000 \
	--env PUID=1000 \
	--env UMASK=002 \
	--restart unless-stopped \
	--network bridge_media \
	--detach \
	linuxserver/tautulli
