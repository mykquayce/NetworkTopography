function Write-Log([string] $Message) {
	$Now = Get-Date -Format "HH:mm:ss"
	Write-Output "$Now : $Message"
}

function Add-Tag([string] $Title) {
	$Body = @{'title' = $Title}
	$Response = Invoke-WebRequest `
		-Body ($Body | ConvertTo-Json -Compress) `
		-Headers @{'Content-Type' = 'application/json'; 'x-api-key' = "${env:ChangeDetectionApiKey}"} `
		-Method POST `
		-Uri 'https://changedetection.bob.house/api/v1/tag'
	$TagId = ($Response.Content | jq --raw-output .uuid)
	return $TagId
}

function Add-Watch([string] $ExtractText, [string] $IncludeFilters, [string] $Tag, [string] $Title, [string] $Uri) {
	$TagId = (Add-Tag -Title "$Tag")

	$Body = @{}
	if ($ExtractText) { $Body.extract_text = @($ExtractText) }
	if ($IncludeFilters) { $Body.include_filters = @($IncludeFilters) }
	if ($Tag) { $Body.tags = @($TagId) }
	if ($Title) { $Body.title = $Title }
	if ($Uri) { $Body.url = $Uri }

	$Response = Invoke-WebRequest `
		-Body ($Body | ConvertTo-Json -Compress) `
		-Headers @{'Content-Type' = 'application/json'; 'x-api-key' = "${env:ChangeDetectionApiKey}"} `
		-Method POST `
		-Uri 'https://changedetection.bob.house/api/v1/watch'

	Write-Log "Added: $Uri"
}


Add-Watch -Tag 'apps' -Title 'https://github.com/AdguardTeam/AdGuardHome/blob/master/internal/filtering/servicelist.go' -Uri 'https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/refs/heads/master/internal/filtering/servicelist.go'
Add-Watch -Tag 'apps' -Title 'https://github.com/goauthentik/authentik/blob/main/.github/actions/setup/compose.yml' -Uri 'https://raw.githubusercontent.com/goauthentik/authentik/refs/heads/main/.github/actions/setup/compose.yml'
Add-Watch -Tag 'apps' -Title 'https://docs.dagu.sh/server-admin/deployment/docker-compose#docker-compose' -Uri 'https://raw.githubusercontent.com/dagucloud/docs/refs/heads/main/server-admin/deployment/docker-compose.md'
Add-Watch -Tag 'apps' -Title 'https://gethomepage.dev/widgets/' -Uri 'https://github.com/gethomepage/homepage/commits/dev/docs/widgets.atom'
Add-Watch -Tag 'apps' -Title 'https://github.com/karakeep-app/karakeep/blob/main/docker/docker-compose.yml' -Uri 'https://raw.githubusercontent.com/karakeep-app/karakeep/refs/heads/main/docker/docker-compose.yml'
Add-Watch -Tag 'apps' -Title 'https://github.com/paperless-ngx/paperless-ngx/blob/dev/docker/compose/docker-compose.postgres.yml' -Uri 'https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/refs/heads/dev/docker/compose/docker-compose.postgres.yml'
Add-Watch -Tag 'apps' -Title 'https://github.com/plankanban/planka/blob/master/docker-compose.yml' -Uri 'https://raw.githubusercontent.com/plankanban/planka/refs/heads/master/docker-compose.yml'
Add-Watch -Tag 'apps' -Title 'https://github.com/go-vikunja/website/blob/main/src/content/docs/setup/docker-start-to-finish.mdx' -Uri 'https://raw.githubusercontent.com/go-vikunja/website/refs/heads/main/src/content/docs/setup/docker-start-to-finish.mdx'

Add-Watch -Tag 'hardware' -IncludeFilters '//div[contains(@class, "cartridge-search-results")]' -Uri 'https://evercade.co.uk/cartridges/'
Add-Watch -Tag 'hardware' -IncludeFilters '//*[contains(@class, "devicename")]' -Uri 'https://wiki.lineageos.org/devices/'

Add-Watch -Tag 'internet' -IncludeFilters 'json:$.ip' -Uri 'https://api.ipapi.is'
Add-Watch -Tag 'internet' -Uri 'https://www.internic.net/domain/named.cache'

Add-Watch -Tag 'kiwix' -ExtractText '/gutenberg_en_all_.+?\.zim/' -Uri 'https://download.kiwix.org/zim/gutenberg/'
Add-Watch -Tag 'kiwix' -ExtractText '/wikibooks_en_all_maxi_.+?\.zim/' -Uri 'https://download.kiwix.org/zim/wikibooks/'
Add-Watch -Tag 'kiwix' -ExtractText '/wikipedia_en_all_maxi_.+?\.zim/' -Uri 'https://download.kiwix.org/zim/wikipedia/'
Add-Watch -Tag 'kiwix' -ExtractText '/wikiquote_en_all_maxi_.+?\.zim/' -Uri 'https://download.kiwix.org/zim/wikiquote/'
Add-Watch -Tag 'kiwix' -ExtractText '/wiktionary_en_all_.+?\.zim/' -Uri 'https://download.kiwix.org/zim/wiktionary/'

Add-Watch -Tag 'software' -title 'https://github.com/awesome-selfhosted/awesome-selfhosted' -Uri 'https://raw.githubusercontent.com/awesome-selfhosted/awesome-selfhosted/refs/heads/master/README.md'
Add-Watch -Tag 'software' -Uri 'https://docs.docker.com/desktop/release-notes/'
Add-Watch -Tag 'software' -IncludeFilters '#supported-versions-table' -Uri 'https://dotnet.microsoft.com/en-us/download/dotnet'
Add-Watch -Tag 'software' -IncludeFilters 'json:$.IDS[0].downloadInfo.DownloadURL' -Title 'Nvidia drivers' -Uri 'https://gfwsl.geforce.com/services_toolkit/services/com/nvidia/services/AjaxDriverService.php?func=DriverManualLookup&psid=120&pfid=942&osID=57&languageCode=1078&beta=0&isWHQL=1&dltype=-1&dch=1&upCRD=0&qnf=0&ctk=null&sort1=1&numberOfResults=1'
Add-Watch -Tag 'software' -Uri 'https://ubuntu.com/download/server'
