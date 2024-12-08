if (!(Test-Path '.\acme.json')) {
	New-Item -Force -ItemType file -Path '.\acme.json';
}

wsl --exec chmod 600 ./acme.json
