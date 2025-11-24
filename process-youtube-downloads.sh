#! /bin/bash

function log() {
	echo "$(date -u +%X) : $1"
}

for path in /mnt/md1/downloads/pinchflat/*/*.mp4
do
	details=$(echo -n $path | rev | cut --delimiter '/' --fields -2 | rev)
	channel=$(echo -n $details | cut --delimiter '/' --fields 1)
	filename=$(echo -n $details | cut --delimiter '/' --fields 2)

	if [[ $filename == '*.mp4' || $filename == *'.f???.mp4' ]]; then
		log "skipping $filename"
		continue
	fi

	log "processing $filename"

	if [ -f "/mnt/md1/youtube/$channel/$filename" ]; then
		log "target exists"
		continue
	fi

	if [ ! -d "/mnt/md1/youtube/$channel/" ]; then
		log "creating target directory for: $channel"
		mkdir --parents --verbose "/mnt/md1/youtube/$channel/"
	fi

	tempnamemp4="/tmp/$(cat /proc/sys/kernel/random/uuid).mp4"
	tempnamepng="/tmp/$(cat /proc/sys/kernel/random/uuid).png"
	tempnametxt="/tmp/$(cat /proc/sys/kernel/random/uuid).txt"

	log 'saving thumbnail'
	ffmpeg -hide_banner -y -i "$path" -map 0:v -map -0:V -c copy "$tempnamepng"

	log 'shrinking'
	ffmpeg -hide_banner -y -i "$path" \
		-map_chapters -1 -r 8 -filter:v fps=fps=8 \
		"$tempnamemp4"

	log 'applying thumbnail'
	ffmpeg -hide_banner -y -i "$tempnamemp4" -i "$tempnamepng" \
		-map 1 -map 0 -codec copy -disposition:0 attached_pic \
		"/mnt/md1/youtube/$channel/$filename"

	log 'cleaning up'
	rm --force --verbose "$tempnamemp4"
	rm --force --verbose "$tempnamepng"
	rm --force --verbose "$tempnametxt"
	rm --force --verbose "$path"

	curl --data "$filename" \
		--header 'Tags: tv,+1' \
		--header "Title: processed $filename" \
		--url 'https://ntfy.bob.house/364d0bdedc5b0bc275b048dc42e342460fb535dc1efcc5daf35460bf4ba4c26e'
done
