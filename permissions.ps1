if (!(Test-Path '~/.certs/acme.json')) {
	New-Item -Force -ItemType file -Path '~/.certs/acme.json';
}

Push-Location '~/.certs/'
wsl --exec chmod -v 600 ./acme.json
Pop-Location
