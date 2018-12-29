#!/usr/bin/env bash

MYSELF="$(cd "$(dirname "$0")" && pwd)/$(basename "$0")"

if [ -z "${CERTBOT_DOMAIN}" ]; then
  mkdir -p "${PWD}/letsencrypt"

  certbot certonly \
    --non-interactive \
    --manual \
    --manual-auth-hook "${MYSELF}" \
    --manual-cleanup-hook "${MYSELF}" \
    --preferred-challenge dns \
    --config-dir "${PWD}/letsencrypt" \
    --work-dir "${PWD}/letsencrypt" \
    --logs-dir "${PWD}/letsencrypt" \
    "$@"

else
  [[ ${CERTBOT_AUTH_OUTPUT} ]] && ACTION="DELETE" || ACTION="UPSERT"

	# echo "aliyun alidns AddDomainRecord --DomainName ${CERTBOT_DOMAIN} --RR _acme-challenge --Type TXT --Value ${CERTBOT_VALIDATION}"
	aliyun alidns AddDomainRecord --DomainName ${CERTBOT_DOMAIN} --RR _acme-challenge --Type TXT --Value ${CERTBOT_VALIDATION}
  echo 1
fi
