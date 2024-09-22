#!/bin/sh

apk add openssl

openssl req -newkey rsa:4096 -nodes -keyout /opt/certs/dev1.key -subj "/C=UK/ST=Manchester/L=Manchester/O=fbc/OU=systems/CN=dev1" -config ./openssl.cnf -out /opt/certs/dev1.csr

openssl x509 -req -extfile ./dev1.ext -days 365 -in /opt/certs/dev1.csr -CA /opt/certs/ca.crt -CAkey /opt/certs/ca.key -CAcreateserial -out /opt/certs/dev1.crt

rm /opt/certs/dev1.csr

ls -al /opt/certs/dev1.*
