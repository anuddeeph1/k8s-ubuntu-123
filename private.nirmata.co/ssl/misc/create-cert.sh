#!/bin/bash
# Cert Creater


passphrase=nirmata
country=US
state=CA
city="San Jose"
user=$1
company="Nirmata Inc."
org=Devops
password=nirmata
company2=Nirmata

./CA.pl -newreq

./CA.pl -sign
 
mv newcert.pem /config/auth/$user.pem
echo "cert file for $user moved"
mv newkey.pem /config/auth/$user.key
echo "key file for $user moved"

openssl rsa -in /config/auth/$user.key -out /config/auth/$user-no-pass.key
mv /config/auth/$user-no-pass.key /config/auth/$user.key
echo "password removed. $user credentials ready."

cat /config/auth/$user.key
cat /config/auth/$user.pem
