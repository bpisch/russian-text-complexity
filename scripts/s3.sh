#! /bin/bash

#3. mondatok megkeverese
for f in ../out/*.s; do
python3 ./preprocess_util/shuffle_lines.py "$f" "${f%.s}.rand"
done
