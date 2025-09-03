#!/bin/sh

docker rm \
	--force \
	--volumes \
	portainer

docker image rm \
	portainer/portainer-ce

docker run \
	--name portainer \
	--hostname portainer \
	--publish 9000:9000 \
	--volume portainer_data:/data \
	--volume /var/run/docker.sock:/var/run/docker.sock \
	--volume /etc/localtime:/etc/localtime:ro \
	--env TZ=America/New_York \
	--env PGID=1000 \
	--env PUID=1000 \
	--env UMASK=002 \
	--restart always \
	--network bridge_all \
	--detach \
	portainer/portainer-ce
