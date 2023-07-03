#!/bin/bash

echo "-> Début du chargement des documents exemples dans les index theses-sample et personnes-sample d'elasticsearch"

/app/theses-sample-load.sh
/app/personnes-sample-load.sh

echo "-> Fin du chargement des documents exemples dans les index theses-sample et personnes-sample d'elasticsearch"

# on ne quitte pas le batch
# pour laisser le conteneur en vie et éviter qu'il soit relancé 
# inutilement quand on appelle "docker-compose up"
sleep infinity