#! /bin/bash

#1. mondatokra vagas
for f in ../input/*.txt; do
bsn=$(basename "$f")
perl cut_nl.pl "$f" > "../out/${bsn%.txt}.s"
done
