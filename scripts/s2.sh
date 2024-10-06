#! /bin/bash

#2. tisztitott szolista keszitese
for f in ../out/*.s; do
perl sub.pl "$f" "${f%.s}.words"
done
