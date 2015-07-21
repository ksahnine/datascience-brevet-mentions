#!/bin/sh

parallel --nonall --basefile get_prenoms_full.sh --slf machines --pipe "./get_prenoms_full.sh" | sort | uniq -c | sort -k2 > stats_brevet_full.csv
