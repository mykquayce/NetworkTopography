#! /bin/bash

function link() {
	ln --force --no-target-directory --verbose $1 $2
}

printf '/work/data/querylog.json*\n' > ~/.adguard01/.kopiaignore
printf '/work/data/querylog.json*\n' > ~/.adguard20/.kopiaignore
printf '/logs/*\n' > ~/.dagu/.kopiaignore
printf '/cache/*\n/logs/*\n' > ~/.kopia/.kopiaignore
printf '/backups/*\n' > ~/.portainer/.kopiaignore

link  ./netplan.yaml  /etc/netplan/50-cloud-init.yaml
