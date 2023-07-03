#!/bin/bash

echo "-> Suppression des anciens fichiers de dump de theses-sample"
rm -f /app/theses-sample-mapping.json
rm -f /app/theses-sample-data.json

echo "-> Dump du mapping depuis l'index theses_test de prod"
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
    --input=https://elastic:${ELASTICSEARCH_PASSWORD}@diplotaxis1-prod.v102.abes.fr:10302/theses_test \
    --output=/app/theses-sample-mapping.json \
    --type=mapping


echo "-> Dump des 11 theses depuis l'index theses_test de prod"
NODE_TLS_REJECT_UNAUTHORIZED=0 elasticdump \
    --input=https://elastic:${ELASTICSEARCH_PASSWORD}@diplotaxis1-prod.v102.abes.fr:10302/theses_test \
    --output=/app/theses-sample-data.json \
    --type=data \
    --searchBody="{\"query\":{\"ids\":{\"values\":[\"2003MON30025\",\"2015TOU20116\",\"2011AIX10218\",\"2001MNHN0022\",\"2020TOU20084\",\"2014TOU20047\",\"2003PA100181\",\"2000PA010697\",\"2014TOU20035\",\"2012PA010501\",\"2020PA100137\"]}}}"
