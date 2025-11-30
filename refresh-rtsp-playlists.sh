#! /bin/sh

for dir in \
	'/mnt/md1/youtube/Lofi Girl/' \
	'/mnt/md1/youtube/Pandora Journey/'
do
	find "$dir" -maxdepth 1 -name '*.mp4' -size +64M | \
		awk -F"/" '{ print "file \047" $NF "\047" }' | \
		tail -n32 | \
		shuf > \
		"${dir}playlist.txt"

	curl --data "$dir"
		--header 'Priority: default' \
		--header 'Tags: musical_note,+1' \
		--header "Title: $dir playlist refeshed" \
		--url 'https://ntfy.bob.house/364d0bdedc5b0bc275b048dc42e342460fb535dc1efcc5daf35460bf4ba4c26e'
done

docker compose --file /root/NetworkTopography/tana/docker-compose.yml \
	up real-time-streaming --detach --force-recreate

sleep 3s

supervisorctl restart lofi pandorajourney
