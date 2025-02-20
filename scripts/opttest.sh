#! /bin/bash

./s1.sh
./s2.sh
for f in ../out/*.s; do
python3 complexity_opttest.py "$f" "${f%.s}.words" "../lists/1000.txt" "../lists/5000.txt"
done
