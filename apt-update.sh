#! /bin/sh

apt update

updates=$( apt list --upgradable 2>/dev/null | tail --lines +2 )

if [ -n "$updates" ]; then

	hostname=$( hostname --long )

	curl --data "$updates" \
		--header 'Priority: high' \
		--header 'Tags: computer,triangular_flag_on_post' \
		--header "Title: $hostname updates" \
		--url 'https://ntfy.bob.house/364d0bdedc5b0bc275b048dc42e342460fb535dc1efcc5daf35460bf4ba4c26e' \
		--verbose

fi
