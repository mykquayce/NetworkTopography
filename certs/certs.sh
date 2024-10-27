#!/bin/sh

apk add openssl

openssl req -newkey rsa:4096 -nodes -keyout /opt/certs/server.key -subj "/C=UK/ST=Manchester/L=Manchester/O=fbc/OU=systems/CN=server" -config ./openssl.cnf -out /opt/certs/server.csr

openssl req -newkey rsa:4096 -nodes -keyout /opt/certs/dev.key -subj "/C=UK/ST=Manchester/L=Manchester/O=fbc/OU=systems/CN=dev" -config ./openssl.cnf -out /opt/certs/dev.csr

openssl x509 -req -extfile ./server.ext -days 365 -in /opt/certs/server.csr -CA /opt/certs/ca.crt -CAkey /opt/certs/ca.key -CAcreateserial -out /opt/certs/server.crt

openssl x509 -req -extfile ./dev.ext -days 365 -in /opt/certs/dev.csr -CA /opt/certs/ca.crt -CAkey /opt/certs/ca.key -CAcreateserial -out /opt/certs/dev.crt

rm /opt/certs/server.csr
rm /opt/certs/dev.csr

ls -al /opt/certs/server.*
ls -al /opt/certs/dev.*
