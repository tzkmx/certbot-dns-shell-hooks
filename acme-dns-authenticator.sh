#!/bin/bash

SUBDOMAIN=$(expr match "$CERTBOT_DOMAIN" '\(.*\)\..*\..*')

source acme_dns/$SUBDOMAIN.ini

echo "Authenticating $CERTBOT_DOMAIN wuth auth.ame-dns.io" | tee -a logs/letsencrypt.log

curl -s -X POST https://auth.acme-dns.io/update \
-H "X-Api-User: $ACME_API_USER" \
-H "X-Api-Key: $ACME_API_KEY" \
--data "{\"subdomain\":\"$ACME_API_SUBDOMAIN\",\"txt\":\"$CERTBOT_VALIDATION\"}" | \
python3 -m json.tool | \
tee -a logs/letsencrypt.log

sleep 25

