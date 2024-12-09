if (!(Test-Path '.\trench\acme.json')) {
	New-Item -Force -ItemType file -Path '.\trench\acme.json';
}

wsl --exec chmod 600 ./trench/acme.json
