this uses the two directory mappings:

| host | container |
| :-: | :-: |
| . | ~/certs/ |
| ~\\.aspnet\https\ | /opt/certs/ |

prep
```
.\launch.ps1
```
authority cert
```
touch ./index.txt
echo 01 > /opt/certs/serial
echo 01 > /opt/certs/crlnumber
openssl genrsa -aes256 -out /opt/certs/ca.key 4096
openssl req -new -x509 -days 365 -key /opt/certs/ca.key -subj "/C=UK/ST=Manchester/L=Manchester/O=fbc/OU=systems/CN=fbc.gov" -config ./openssl.cnf -out /opt/certs/ca.crt
```
revocation list
```
openssl ca -config ./openssl.cnf -gencrl -keyfile /opt/certs/ca.key -cert /opt/certs/ca.crt -out /opt/certs/crl.crt
```
certs

run these (will prompt for the passphrase)
```
./server1.sh
./dev1.sh
```
