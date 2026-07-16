#! /bin/bash

ln --force --no-target-directory --verbose \
	"./netplans/$(hostname --short).yaml" \
	"/etc/netplan/50-cloud-init.yaml"
