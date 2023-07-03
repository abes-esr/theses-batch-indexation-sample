#!/bin/bash

echo "-> Suppression de l'eventuel ancien index theses-sample dans elasticsearch"
curl -k --request DELETE \
  -u elastic:${ELASTICSEARCH_PASSWORD} \
  --url "https://${ELASTICSEARCH_HOST}/theses-sample?pretty=true"

echo "-> Chargement du mapping de l'index theses-sample dans elasticsearch"
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
  --input=/app/theses-sample-mapping.json \
  --output-index=theses-sample \
  --output=https://elastic:${ELASTICSEARCH_PASSWORD}@${ELASTICSEARCH_HOST}/ \
  --type=mapping

echo "-> Chargement des documents dans l'index theses-sample d'elasticsearch"
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
  --input=/app/theses-sample-data.json \
  --output-index=theses-sample \
  --output=https://elastic:${ELASTICSEARCH_PASSWORD}@${ELASTICSEARCH_HOST}/ \
  --type=data
