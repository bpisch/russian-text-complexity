#! /usr/bin/python3
import sys

from utils import calc_avg_sils, calc_avg_sents, filter_words, write_to_file_and_stdout


def fkg(asl, asw):
    return 0.2269 * asl + 3.3173 * asw - 2.4248


def dc(dwp_5000, asl):
    return 0.1027 * dwp_5000 + 0.2753 * asl + 0.9304


def dc_ext(dwp_1000, dwp_5000, asl):
    return -0.5921 * dwp_1000 + 0.6362 * dwp_5000 + 0.1827 * asl + 11.6611


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
