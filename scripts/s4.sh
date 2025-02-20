#! /bin/bash

#4. darabolas tanitashoz
for f in ../out/*.rand; do
python3 ./preprocess_util/part.py "$f" "${f%.rand}" 11
done
mv ../out/*_part* ../parts/
