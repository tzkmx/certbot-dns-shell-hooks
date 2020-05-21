#! /bin/bash

source config.ini

SUBDOMAINS=""

for subdomain in $(find acme_dns/ -type f | sed -n -e '/.example/d;s/acme_dns\/\(.*\)\.ini/\1/;p;') ;
  do SUBDOMAINS="$SUBDOMAINS -d $subdomain.$BASE_DOMAIN " ;
done

COMMON_CERTBOT_ARGS="--eff-email --agree-tos -m $ACCT_EMAIL --manual-public-ip-logging-ok --work-dir ./work --logs-dir ./logs/ --config-dir ./workdir --manual --preferred-challenges=dns --manual-auth-hook ./acme-dns-authenticator.sh $SUBDOMAINS"

if [ "false" != $IS_TEST ]
then
	certbot certonly --test-cert $COMMON_CERTBOT_ARGS
else 
	certbot certonly $COMMON_CERTBOT_ARGS
fi

