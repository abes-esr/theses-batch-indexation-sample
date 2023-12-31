# theses-batch-indexation-sample

[![build-test-pubtodockerhub](https://github.com/abes-esr/theses-batch-indexation-sample/actions/workflows/build-test-pubtodockerhub.yml/badge.svg)](https://github.com/abes-esr/theses-batch-indexation-sample/actions/workflows/build-test-pubtodockerhub.yml) [![Docker Pulls](https://img.shields.io/docker/pulls/abesesr/theses.svg)](https://hub.docker.com/r/abesesr/theses/)

Programme qui permet de charger un jeu de données dans une instance [theses-docker](https://github.com/abes-esr/theses-docker) vierge.
Ce script est automatiquement lancé au démarrage de theses-docker. Il va se charger de créer les 3 indexes suivants :
- `theses-sample` (qui contient 13 thèses)
- `personnes-sample` (qui contient 3 personnes)
- `recherche_personnes-sample` (qui contient 3 personnes, la même qu'au dessus)

Ces trois indexes permettent de faire fonctionner [theses-docker](https://github.com/abes-esr/theses-docker) en toute indépendance du SI de l'Abes et en particulier la base de données Oracle contenant les TEF des thèses (métadonnées XML).

Ce programme utilise l'outil [elasticsearch-dump](https://github.com/elasticsearch-dump/elasticsearch-dump) et jq pour générer les dumps et pour charger les dumps.

## Paramètres

Les paramètres suivants sont attendus sous forme de variable d'environnement passés au conteneur docker :
- `ELASTICSEARCH_PASSWORD` : le mot de passe correspondant au user `elastic`
- `ELASTICSEARCH_HOST_PORT` : le hostname+port de l'instance elasticsearch, par exemple pour une instance locale : `127.0.0.1:10302` 

## Développement

Il est possible de travailler sur ce programme indépendement de [theses-docker](https://github.com/abes-esr/theses-docker) de cette manière :
```bash
# build de l'image docker en local
docker build . -t theses-batch-indexation-sample:local

# execution du conteneur (remplacer 'xxxxxx' par le mot de passe du user 'elastic')
docker run --rm -it --net=host \
  -e ELASTICSEARCH_PASSWORD=xxxxxx \
  -e ELASTICSEARCH_HOST_PORT=127.0.0.1:10302 \
  --name=theses-batch-indexation-sample-container \
  theses-batch-indexation-sample:local
```

Pour régénérer les dumps, vous pouvez procéder comme ceci :
```bash
# 1. lancer le conteneur dans un onglet, cf commande ci-dessus
# 2. regénérer les dumps de cette manière (ils seront stockés dans le conteneur)
docker exec -it theses-batch-indexation-sample-container /app/personnes-sample-dump.sh
docker exec -it theses-batch-indexation-sample-container /app/theses-sample-dump.sh
# 3. copier les dumps générés en local pour pouvoir les commit/push sur git si souhaité
docker cp theses-batch-indexation-sample-container:/app/personnes-sample-data.json ./personnes-sample-data.json
docker cp theses-batch-indexation-sample-container:/app/personnes-sample-mapping.json ./personnes-sample-mapping.json
docker cp theses-batch-indexation-sample-container:/app/recherche_personnes-sample-data.json ./recherche_personnes-sample-data.json
docker cp theses-batch-indexation-sample-container:/app/recherche_personnes-sample-mapping.json ./recherche_personnes-sample-mapping.json
docker cp theses-batch-indexation-sample-container:/app/theses-sample-mapping.json ./theses-sample-mapping.json
docker cp theses-batch-indexation-sample-container:/app/theses-sample-data.json ./theses-sample-data.json
```
