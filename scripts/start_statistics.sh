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

echo "asw	aswc	asl	aslc	grade	dwp_1000	dwp_1500	dwp_2000	dwp_3000	dwp_5000	dwp_10000	dwp_20000	dwp_30000	dwp_40000	dwp_50000	dwp_100000	filename" > out_statistics.txt
for f in ../out/*.s; do
python3 combined_statsv2.py "$f" "${f%.s}.words" "../lists/1000.txt" "../lists/1500.txt" "../lists/2000.txt" "../lists/3000.txt" "../lists/5000.txt" "../lists/10000.txt" "../lists/20000.txt" "../lists/30000.txt" "../lists/40000.txt" "../lists/50000.txt" "../lists/100000.txt" | tee -a out_statistics.txt
done

