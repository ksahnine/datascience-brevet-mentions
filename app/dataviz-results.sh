#!/bin/sh

if [ ! -f brevet-mentions-2015.csv ]
then
    echo "Fichier brevet-mentions-2015.csv introuvable"
    echo "Lancer d'abord la commande ./reduce-join_results.sh"
    exit 1
fi

gnuplot <<EOF
plot "brevet-mentions-2015.csv" u 4:3:1 w labels rotate by 20 font "Helvetica,8"
EOF
