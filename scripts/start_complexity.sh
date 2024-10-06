#! /bin/bash

./clean.sh
if [ ! -d "./../input" ]; then
    echo "Input folder does not exist!"
    exit 1
fi
mkdir -p "./../out"
./s1.sh
echo "s1.sh finished"
./s2.sh
echo "s2.sh finished"

for f in ../out/*.s; do
python3 complexity.py "$f" "${f%.s}.words" "../lists/1000.txt" "../lists/5000.txt"
done
python3 complexity_sorter.py "complexity.txt" "out_complexity_fkg.txt" "fkg"
python3 complexity_sorter.py "complexity.txt" "out_complexity_dc.txt" "dc"
python3 complexity_sorter.py "complexity.txt" "out_complexity_dc_ext.txt" "dc_ext"
rm -f complexity.txt

