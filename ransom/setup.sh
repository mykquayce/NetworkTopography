#! /bin/bash

function link() {
	ln --force --no-target-directory --verbose $1 $2
}

printf '/cache/*\n' > ~/.freshrss/.kopiaignore
printf '/cache/*\n/logs/*\n' > ~/.kopia/.kopiaignore
printf '/data/log/*\n' > ~/.paperless-ngx/.kopiaignore
printf '/backup/*\n/log/*\n/tmp/*\n' > ~/.trilium/.kopiaignore

link  ./netplan.yaml  /etc/netplan/50-cloud-init.yaml
