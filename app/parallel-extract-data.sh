#!/bin/sh

# Extract data

if [ ! -f communes.txt ]
then
    echo "Fichier communes.csv introuvable"
    echo "Lancer d'abord la commande ./extract_brevet.py > communes.csv"
    exit 1
else
    parallel -a communes.csv --colsep ' ' -j 10 --basefile ac_scrap.py --slf machines "./ac_scrap.py -a {1} -d {2} -c {3} 2> {3}.log"
fi
