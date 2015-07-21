#!/bin/sh
find output -type f -name "Serie-Generale.csv" -exec cat {} \; | cut -d';' -f7 
