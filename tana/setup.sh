#! /bin/bash

function link() {
	ln --force --no-target-directory --verbose $1 $2
}

printf '/audiobooks/*\n/podcasts/*\n' > ~/.audiobookshelf/.kopiaignore
printf '/cache/*\n/config/log/*\n/config/metadata/*\n' > ~/.jellyfin/.kopiaignore
printf '/logs/*\n' > ~/.jellyseerr/.kopiaignore
printf '/cache/*\n/logs/*\n' > ~/.kopia/.kopiaignore
printf '/Backups/*\n/logs/*\n/config/metadata/*\n' > ~/.lidarr/.kopiaignore
printf '/temp/*\n/state/*.old\n' > ~/.metube/.kopiaignore
printf '/cache/*\n' > ~/.navidrome/.kopiaignore
printf '/config/logs/*\n' > ~/.pinchflat/.kopiaignore
printf '/Backups/*\n/logs/*\n/logs.db\n' > ~/.prowlarr/.kopiaignore
printf '/qBittorrent/logs/*\n' > ~/.qbittorrent/.kopiaignore
printf '/Backups/*\n/logs/*\n' > ~/.radarr/.kopiaignore
printf '/logs/*\n' > ~/.sabnzbd/.kopiaignore
printf '/data/Logs/*\n/data/backup/*\n/data/cache/*\n' > ~/.sickgear/.kopiaignore
printf '/Backups/*\n/logs/*\n' > ~/.sonarr/.kopiaignore
printf '/backups/*\n/cache/*\n/logs/*\n' > ~/.tunarr/.kopiaignore

link  ./netplan.yaml  /etc/netplan/50-cloud-init.yaml
