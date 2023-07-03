#!/bin/bash

echo "-> Suppression de l'eventuel ancien index personnes-sample dans elasticsearch"
curl -k --request DELETE \
  -u elastic:${ELASTICSEARCH_PASSWORD} \
  --url "https://${ELASTICSEARCH_HOST_PORT}/personnes-sample?pretty=true"
echo "-> Suppression de l'eventuel ancien index recherche_personnes-sample dans elasticsearch"
curl -k --request DELETE \
  -u elastic:${ELASTICSEARCH_PASSWORD} \
  --url "https://${ELASTICSEARCH_HOST_PORT}/recherche_personnes-sample?pretty=true"


echo "-> Chargement du mapping de l'index personnes-sample dans elasticsearch"
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
  --input=/app/personnes-sample-mapping.json \
  --output-index=personnes-sample \
  --output=https://elastic:${ELASTICSEARCH_PASSWORD}@${ELASTICSEARCH_HOST_PORT}/ \
  --type=index
echo "-> Chargement du mapping de l'index recherche_personnes-sample dans elasticsearch"
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
  --input=/app/recherche_personnes-sample-mapping.json \
  --output-index=recherche_personnes-sample \
  --output=https://elastic:${ELASTICSEARCH_PASSWORD}@${ELASTICSEARCH_HOST_PORT}/ \
  --type=index


echo "-> Chargement des documents dans l'index personnes-sample d'elasticsearch"
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
  --input=/app/personnes-sample-data.json \
  --output-index=personnes-sample \
  --output=https://elastic:${ELASTICSEARCH_PASSWORD}@${ELASTICSEARCH_HOST_PORT}/ \
  --type=data
echo "-> Chargement des documents dans l'index recherche_personnes-sample d'elasticsearch"
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
  --input=/app/recherche_personnes-sample-data.json \
  --output-index=recherche_personnes-sample \
  --output=https://elastic:${ELASTICSEARCH_PASSWORD}@${ELASTICSEARCH_HOST_PORT}/ \
  --type=data
