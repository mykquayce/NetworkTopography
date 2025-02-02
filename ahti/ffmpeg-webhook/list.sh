#! /bin/sh

find "/videos/$1/" | jq --raw-input | jq --compact-output --slurp
