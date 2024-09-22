#!/bin/sh

apk add openssl

openssl req -newkey rsa:4096 -nodes -keyout /opt/certs/server1.key -subj "/C=UK/ST=Manchester/L=Manchester/O=fbc/OU=systems/CN=server1" -config ./openssl.cnf -out /opt/certs/server1.csr

openssl x509 -req -extfile ./server1.ext -days 365 -in /opt/certs/server1.csr -CA /opt/certs/ca.crt -CAkey /opt/certs/ca.key -CAcreateserial -out /opt/certs/server1.crt

rm /opt/certs/server1.csr

ls -al /opt/certs/server1.*
