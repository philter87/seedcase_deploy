#!/usr/bin/env bash
# exit on error
set -o errexit

echo pwd
ls

if [ ! -f "persistence/tls.cert" ]
then
  TLS_HOSTNAME="${TLS_HOSTNAME:-localhost}"
  mkdir -p "persistence"
  SUBJ="/C=DK/ST=Jylland/L=Aarhus/O=SDCA/CN=${TLS_HOSTNAME}"
  echo "Create certificate with subject: $SUBJ"
  MSYS_NO_PATHCONV=1 openssl req -new -newkey rsa:4096 -nodes -keyout persistence/tls.key -out persistence/tls.csr -subj "$SUBJ" -addext "subjectAltName = DNS:localhost"
  MSYS_NO_PATHCONV=1 openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "$SUBJ" -keyout persistence/tls.key -out persistence/tls.cert -addext "subjectAltName = DNS:localhost"
fi

poetry run python manage.py migrate
poetry run gunicorn --certfile="persistence/tls.cert" --keyfile="persistence/tls.key" seedcase_deploy.wsgi:app --bind 0.0.0.0:10000