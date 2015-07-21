#!/bin/sh

parallel --nonall --basefile get_prenoms_meTB.sh --slf machines --pipe "./get_prenoms_meTB.sh" | sort | uniq -c | sort -k2 > stats_brevet_meTB.csv
