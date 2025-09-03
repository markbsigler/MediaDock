#!/bin/sh
#list="portainer deluge-openvpn jackett lidarr radarr sonarr bazarr ombi"
list="portainer delugevpn jackett lidarr radarr sonarr bazarr ombi"

echo "docker will run these containers: ${list}"

for l in $list
do
	if [ -x ${l}/docker-run.sh ]
	then
		${l}/docker-run.sh
	else
		echo "${l} doesn't have a docker-run.sh executable"
	fi
done
