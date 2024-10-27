docker pull alpine:latest
if (!$?) { exit; }

docker run --interactive=true --rm --tty=true `
	--volume "${env:userprofile}\.aspnet\https\:/opt/certs/:rw" `
	--volume '.:/root/certs/:rw' `
	alpine:latest `
	sh -c 'cd /root/certs/; dos2unix *.*; exec /bin/sh'
