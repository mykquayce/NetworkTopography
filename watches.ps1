$watches = `
	#apps
	'{"title":"https://github.com/goauthentik/authentik/blob/main/.github/actions/setup/compose.yml","url":"https://raw.githubusercontent.com/goauthentik/authentik/refs/heads/main/.github/actions/setup/compose.yml"}', `
	'{"title":"https://gethomepage.dev/widgets/","url":"https://github.com/gethomepage/homepage/commits/dev/docs/widgets.atom"}', `
	'{"title":"https://github.com/karakeep-app/karakeep/blob/main/docker/docker-compose.yml","url":"https://raw.githubusercontent.com/karakeep-app/karakeep/refs/heads/main/docker/docker-compose.yml"}', `
	'{"title":"https://github.com/paperless-ngx/paperless-ngx/blob/dev/docker/compose/docker-compose.postgres.yml","url":"https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/refs/heads/dev/docker/compose/docker-compose.postgres.yml"}', `
	'{"title":"https://github.com/plankanban/planka/blob/master/docker-compose.yml","url":"https://raw.githubusercontent.com/plankanban/planka/refs/heads/master/docker-compose.yml"}', `
	'{"title":"https://github.com/go-vikunja/website/blob/main/src/content/docs/setup/docker-start-to-finish.mdoc","url":"https://raw.githubusercontent.com/go-vikunja/website/refs/heads/main/src/content/docs/setup/docker-start-to-finish.mdoc"}', `

	#hardware
	'{"include_filters":["//div[contains(@class, ''cartridge-search-results'')]"],"url":"https://evercade.co.uk/cartridges/"}', `
	'{"include_filters":["//*[contains(@class, ''devicename'')]"],"url":"https://wiki.lineageos.org/devices/"}', `

	#internet
	'{"include_filters":["json:$.ip"],"url":"https://api.ipapi.is"}', `
	'{"url":"https://www.internic.net/domain/named.cache"}', `

	#kiwix
	'{"extract_text":["/gutenberg_en_all_.+?\\.zim/"],"url":"https://download.kiwix.org/zim/gutenberg/"}', `
	'{"extract_text":["/wikipedia_en_all_maxi_.+?\\.zim/"],"url":"https://download.kiwix.org/zim/wikipedia/"}', `
	'{"extract_text":["/wikiquote_en_all_maxi_.+?\\.zim/"],"url":"https://download.kiwix.org/zim/wikiquote/"}', `
	'{"extract_text":["/wiktionary_en_all_.+?\\.zim/"],"url":"https://download.kiwix.org/zim/wiktionary/"}', `

	#software
	'{"title":"https://github.com/awesome-selfhosted/awesome-selfhosted","url":"https://raw.githubusercontent.com/awesome-selfhosted/awesome-selfhosted/refs/heads/master/README.md"}', `
	'{"url":"https://docs.docker.com/desktop/release-notes/"}', `
	'{"include_filters":["#supported-versions-table"],"url":"https://dotnet.microsoft.com/en-us/download/dotnet"}', `
	'{"include_filters":["json:$.IDS[0].downloadInfo.DownloadURL"],"title":"Nvidia drivers","url":"https://gfwsl.geforce.com/services_toolkit/services/com/nvidia/services/AjaxDriverService.php?func=DriverManualLookup&psid=120&pfid=942&osID=57&languageCode=1078&beta=0&isWHQL=1&dltype=-1&dch=1&upCRD=0&qnf=0&ctk=null&sort1=1&numberOfResults=1"}', `
	'{"url":"https://ubuntu.com/download/server"}'

foreach ($watch in $watches) {
	curl --data "$watch" `
		--header "Content-Type: application/json" `
		--header "x-api-key: ${env:ChangeDetectionApiKey}" `
		--url 'https://changedetection.bob.house/api/v1/watch'
}
