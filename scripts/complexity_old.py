#! /usr/bin/python3
import sys

from utils import calc_avg_sils, calc_avg_sents, filter_words, write_to_file_and_stdout


def fkg(asl, asw):
    return 4.3011 + 1.0286 * asw + 0.1649 * asl


def dc(dwp_5000, asl):
    return 4.0880 + 0.0715 * dwp_5000 + 0.1763 * asl


def dc_ext(dwp_1000, dwp_5000, asl):
    return 4.8929 + 0.1457 * dwp_5000 + 0.1778 * asl + -0.0700 * dwp_1000


def find_input_name(original_path):
    last_slash_index = original_path.rfind('/')
    if last_slash_index != -1:
        filename = original_path[last_slash_index + 1:]
    else:
        filename = original_path
    if filename.endswith('.s'):
        filename = filename[:-2] + '.txt'
    return filename


def main():
    sentences = open(sys.argv[1], "r", encoding="utf-8").read()
    clean_words = open(sys.argv[2], "r", encoding="utf-8").read()
    freqs = sys.argv[3:]
    asw = calc_avg_sils(clean_words)
    asl = calc_avg_sents(sentences)
    dwp_map = {}
    dwp_list = [1000, 5000]
    for f in freqs:
        number = int(f.split('/')[-1].split('.')[0])
        if number in dwp_list:
            fd = open(f, "r", encoding="utf-8")
            flist = fd.read()
            fd.close()
            dwp_map[number] = filter_words(clean_words, flist)

    with open("complexity.txt", 'a') as file:
        write_to_file_and_stdout(file,
                                 f"{find_input_name(sys.argv[1])}\tfkg={fkg(asl, asw):.4f}\tdc={dc(dwp_map[5000], asl):.4f}\tdc_ext={dc_ext(dwp_map[1000], dwp_map[5000], asl):.4f}\tasl={asl:.4f}\tasw={asw:.4f}\tdwp_1000={dwp_map[1000]:.4f}\tdwp_5000={dwp_map[5000]:.4f}\n")


if __name__ == "__main__":
    main()
