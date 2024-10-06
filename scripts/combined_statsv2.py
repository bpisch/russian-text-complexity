#! /usr/bin/python3
import sys

from utils import calc_avg_sils, calc_avg_wl, calc_avg_sents, calc_avg_sent_chars, calc_class, filter_words


# parameterek: 1. mondatra vagott, 2. tisztitott szolista, 3. szogyakorisagi lista
def main():
    sentences = open(sys.argv[1], "r", encoding="utf-8").read()
    clean_words = open(sys.argv[2], "r", encoding="utf-8").read()
    freqs = sys.argv[3:]
    out_str = ""
    # 1
    out_str += str(calc_avg_sils(clean_words)) + "\t"
    # 2
    out_str += str(calc_avg_wl(clean_words)) + "\t"
    # 3
    out_str += str(calc_avg_sents(sentences)) + "\t"
    # 4
    out_str += str(calc_avg_sent_chars(sentences)) + "\t"
    # 5
    out_str += str(calc_class(sys.argv[1])) + "\t"
    # 6
    for f in freqs:
        fd = open(f, "r", encoding="utf-8")
        flist = fd.read()
        fd.close()
        out_str += str(filter_words(clean_words, flist)) + "\t"
    out_str += sys.argv[1].split("/")[-1]
    print(out_str)


main()
