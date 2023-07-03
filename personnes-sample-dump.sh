#!/bin/bash

echo "-> Suppression des anciens fichiers de dump de personnes-sample et recherche_personnes-sample"
rm -f /app/personnes-sample-mapping.json
rm -f /app/personnes-sample-data.json
rm -f /app/recherche_personnes-sample-mapping.json
rm -f /app/recherche_personnes-sample-data.json

echo "-> Dump du mapping depuis l'index personnes de prod"
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
    --input=https://elastic:${ELASTICSEARCH_PASSWORD}@diplotaxis1-prod.v102.abes.fr:10302/personnes \
    --output=/app/personnes-sample-mapping.json \
    --type=index
echo "-> Dump du mapping depuis l'index recherche_personnes de prod"
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
    --input=https://elastic:${ELASTICSEARCH_PASSWORD}@diplotaxis1-prod.v102.abes.fr:10302/recherche_personnes \
    --output=/app/recherche_personnes-sample-mapping.json \
    --type=index


echo "-> Dump de 2 personnes depuis l'index personnes de prod"
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
    --input=https://elastic:${ELASTICSEARCH_PASSWORD}@diplotaxis1-prod.v102.abes.fr:10302/personnes \
    --output=$ \
    --type=data \
    --searchBody="{\"query\":{\"ids\":{\"values\":[\"027084868\",\"029561248\",\"139254544\"]}}}" \
  | jq -c -M 'del(._source.theses)' > /app/personnes-sample-data.json

echo "-> Dump de 2 personnes depuis l'index recherche_personnes de prod"
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
    --input=https://elastic:${ELASTICSEARCH_PASSWORD}@diplotaxis1-prod.v102.abes.fr:10302/recherche_personnes \
    --output=/app/recherche_personnes-sample-data.json \
    --type=data \
    --searchBody="{\"query\":{\"ids\":{\"values\":[\"027084868\",\"029561248\",\"139254544\"]}}}"
