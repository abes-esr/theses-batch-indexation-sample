# theses-batch-indexation-sample

[![build-test-pubtodockerhub](https://github.com/abes-esr/theses-batch-indexation-sample/actions/workflows/build-test-pubtodockerhub.yml/badge.svg)](https://github.com/abes-esr/theses-batch-indexation-sample/actions/workflows/build-test-pubtodockerhub.yml) [![Docker Pulls](https://img.shields.io/docker/pulls/abesesr/theses.svg)](https://hub.docker.com/r/abesesr/theses/)

Programme qui permet de charger un jeu de données dans une instance theses-docker vierge.
Ce script est automatiquement lancé au démarrage de theses-docker. Il va se charger de créer les 3 indexes suivants :
- theses-sample (qui contient 11 thèses)
- personnes-sample (qui contient 1 personne)
- recherche_personnes-sample (qui contient 1 personne, la même qu'au dessus)

Ces trois indexes permettent de faire fonctionner theses-docker en toute indépendance du SI de l'Abes et en particulier la base de données Oracle contenant les TEF des thèses (métadonnées XML).

