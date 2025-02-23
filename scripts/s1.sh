#! /bin/bash

#1. mondatokra vagas
for f in ../input/*.txt; do
bsn=$(basename "$f")
perl cut_nl.pl "$f" 
perl clean.pl "../out/${bsn%.txt}.s"
rm temp_temp_rus.txt
done
