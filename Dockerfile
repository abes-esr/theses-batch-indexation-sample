# hérite de https://github.com/elasticsearch-dump/elasticsearch-dump
# qui permet de mettre à dispo la ligne de commande elasticdump
FROM elasticdump/elasticsearch-dump:v6.103.0

# curl : pour l'interaction avec l'API d'elasticsearch (exn particulier pour supprimer des indexes)
# jq : pour manipuler les JSON, en particulier pour retirer les nested du dump de l'index 'personnes'
RUN apt update && apt install -y jq curl

# données et scripts de :
# - theses-sample
# - personnes-sample
# - recherche_personnes-sample
WORKDIR /app/
COPY ./*.sh /app/
COPY ./*.json /app/
RUN chmod a+x /app/*.sh

ENTRYPOINT [ "/app/index-sample-load.sh" ]
