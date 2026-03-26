#! /bin/bash

function link() {
	ln --force --no-target-directory --verbose $1 $2
}

printf '/media/recordings/*\n' > ~/.frigate/.kopiaignore
printf '/cache/*\n/logs/*\n' > ~/.kopia/.kopiaignore

link  ./netplan.yaml  /etc/netplan/50-cloud-init.yaml
