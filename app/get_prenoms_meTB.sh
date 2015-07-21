#!/bin/sh
find output -type f -name "Serie-Generale.csv" -exec cat {} \; | grep "TRES BIEN" | cut -d';' -f7
