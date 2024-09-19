prep
```
docker pull alpine:latest
docker run --interactive=true --rm --tty=true --volume "${env:userprofile}\.aspnet\https\:/root/ca/:rw" alpine:latest sh
apk add openssl
cd /root/ca/
touch ./index.txt
echo 01 > ./serial
echo 01 > ./crlnumber
```
authority cert
```
openssl genrsa -aes256 -out ./ca.key 4096
openssl req -new -x509 -days 365 -key ./ca.key -subj "/C=UK/ST=Manchester/L=Manchester/O=fbc/OU=systems/CN=fbc.gov" -config ./openssl.cnf -out ./ca.crt
```
revocation list
```
openssl ca -config ./openssl.cnf -gencrl -keyfile ./ca.key -cert ./ca.crt -out ./crl.crt
```
server1 cert
```
openssl req -newkey rsa:4096 -nodes -keyout ./server1.key -subj "/C=UK/ST=Manchester/L=Manchester/O=fbc/OU=systems/CN=server1" -config ./openssl.cnf -out ./server1.csr
openssl x509 -req -extfile <(printf "crlDistributionPoints=URI:http://certificates/crl.crt\nsubjectAltName=DNS:api,DNS:baget,DNS:grafana,DNS:homeassistant,DNS:host.docker.internal,DNS:httpbin,DNS:identityserver,DNS:localhost,DNS:mariadb,DNS:networkdiscovery,DNS:networktest,DNS:nuget,DNS:pihole,DNS:planka,DNS:prometheus,DNS:registry,DNS:registry.local,DNS:router1,DNS:tplink,DNS:traefik") -days 365 -in ./server1.csr -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -out ./server1.crt
```
mediaserver1 cert
```
openssl req -newkey rsa:4096 -nodes -keyout ./mediaserver1.key -subj "/C=UK/ST=Manchester/L=Manchester/O=fbc/OU=systems/CN=mediaserver1" -config ./openssl.cnf -out ./mediaserver1.csr
openssl x509 -req -extfile <(printf "crlDistributionPoints=URI:http://certificates/crl.crt\nsubjectAltName=DNS:host.docker.internal,DNS:jellyfin,DNS:localhost,DNS:qbittorrent,DNS:sickgear,DNS:traefik") -days 365 -in ./mediaserver1.csr -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -out ./mediaserver1.crt
```
dev1 cert
```
openssl req -newkey rsa:4096 -nodes -keyout ./dev1.key -subj "/C=UK/ST=Manchester/L=Manchester/O=fbc/OU=systems/CN=dev1" -config ./openssl.cnf -out ./dev1.csr
openssl x509 -req -extfile <(printf "crlDistributionPoints=URI:http://certificates/crl.crt\nsubjectAltName=DNS:database,DNS:directory,DNS:dylan3,DNS:gaining,DNS:host.docker.internal,DNS:httpbin,DNS:identityserver,DNS:jellyfin,DNS:localhost,DNS:losing,DNS:totsco,DNS:traefik") -days 365 -in ./dev1.csr -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -out ./dev1.crt
```
