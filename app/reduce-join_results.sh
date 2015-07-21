#!/bin/sh

if [ ! -f stats_brevet_full.csv ]
then
    echo "Fichier stats_brevet_full.csv introuvable"
    echo "Lancer d'abord la commande ./parallel-get_prenoms_full.sh"
    exit 1
fi
if [ ! -f stats_brevet_meTB.csv ]
then
    echo "Fichier stats_brevet_meTB.csv introuvable"
    echo "Lancer d'abord la commande ./parallel-get_prenoms_meTB.sh"
    exit 2
fi

join -1 2 -2 2 stats_brevet_meTB.csv stats_brevet_full.csv | awk '$3 > 190 { printf("%s %d %d %2.1f\n", $1, $2, $3, ($2/$3)*100) }' > brevet-mentions-2015.csv
