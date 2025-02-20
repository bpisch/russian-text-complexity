#! /bin/bash

#5. szetdarabolt mondatlistakbol szolista keszitese
for f in ../parts/*.s; do
perl sub.pl "$f" "${f%.s}.words"
done
