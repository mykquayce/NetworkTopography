#! /bin/bash

ln --force --no-target-directory --verbose \
	"./$(hostname --short)/netplan.yaml" \
	"/etc/netplan/50-cloud-init.yaml"
