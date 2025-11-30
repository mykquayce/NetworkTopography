#! /bin/bash

function log() {
	echo "$(date -u +%X) : $1"
}

for path in /mnt/md1/downloads/pinchflat/shrink/*/*.mp4
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

	tempname1mp4="/tmp/$(cat /proc/sys/kernel/random/uuid).mp4"
	tempname2mp4="/tmp/$(cat /proc/sys/kernel/random/uuid).mp4"
	tempnamepng="/tmp/$(cat /proc/sys/kernel/random/uuid).png"
	tempnametxt="/tmp/$(cat /proc/sys/kernel/random/uuid).txt"

	log 'saving thumbnail'
	ffmpeg -hide_banner -y -i "$path" -map 0:v -map -0:V -c copy "$tempnamepng"

	log 'extracting metadata'
	ffmpeg -hide_banner -y -i "$path" -f ffmetadata "$tempnametxt"

	log 'fixing metadata'
	for line in $(cat "$tempnametxt")
	do
		if [[ "$line" =~ ^(END|START)=([0-9]+)$ ]]; then
			key=${BASH_REMATCH[1]}
			original_time=${BASH_REMATCH[2]}
			adjusted_time=$((($original_time * 10) / 13))
			sed --expression "s/^${line}$/${key}=${adjusted_time}/" --in-place "$tempnametxt"
		fi
	done

	log 'shrinking'
	ffmpeg -hide_banner -y -i "$path" \
		-map_chapters -1 \
		-r 8 -filter:a atempo=1.3 -filter:v fps=fps=8,setpts=PTS/1.3 \
		"$tempname1mp4"

	log 'applying metadata'
	ffmpeg -hide_banner -y -i "$tempname1mp4" \
		-i "$tempnametxt" \
		-map_metadata 1 \
		-map 0 -codec copy \
		"$tempname2mp4"

	log 'cleaning up'
	rm --force --verbose "$tempname1mp4"
	rm --force --verbose "$tempnametxt"

	log 'applying thumbnail'
	ffmpeg -hide_banner -y -i "$tempname2mp4" -i "$tempnamepng" \
		-map 1 -map 0 -codec copy -disposition:0 attached_pic \
		"/mnt/md1/youtube/$channel/$filename"

	log 'cleaning up'
	rm --force --verbose "$tempname2mp4"
	rm --force --verbose "$tempnamepng"
	rm --force --verbose "$path"

	curl --data "$filename" \
		--header 'Tags: tv,+1' \
		--header "Title: processed and sped-up $filename" \
		--url 'https://ntfy.bob.house/364d0bdedc5b0bc275b048dc42e342460fb535dc1efcc5daf35460bf4ba4c26e'
done
