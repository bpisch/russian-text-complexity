#! /usr/bin/python3
import re


# 1 - szotagok atlaga
def num_of_sils(w):
    sils = 0
    for c in w:
        if c in "аеёяюиоуэыАЕЁЯЮИОУЭЫ": sils += 1
    return sils


def calc_avg_sils(wordlist):
    sils = []
    words = wordlist.split("\n")
    for w in words:
        if w == "": continue
        sils.append(num_of_sils(w))
    return round(sum(sils) / len(sils), 2)


# 2 - karakterek atlaga szoban
def calc_avg_wl(wordlist):
    lengths = []
    wordlist = wordlist.split("\n")
    for w in wordlist:
        if w == "": continue
        lengths.append(len(w))
    return round(sum(lengths) / len(lengths), 2)


# 3 - szavak atlaga mondatban, kiveve 5 leghosszabb
def calc_avg_sents(sents):
    lengths = []
    sents = sents.split("\n")
    for s in sents:
        if s != "": lengths.append(len(s.split(" ")))
    for i in range(5): lengths.remove(max(lengths))
    return round(sum(lengths) / len(lengths), 2)


# 4 - karakterek atlaga mondatban, kiveve 5 leghosszabb
def calc_avg_sent_chars(sents):
    lengths = []
    sents = sents.split("\n")
    for s in sents:
        if s != "": lengths.append(len(s))
    for i in range(5): lengths.remove(max(lengths))
    return round(sum(lengths) / len(lengths), 2)


# 5 - osztaly ha ez az informacio adott (ha nem adott akkor -1)
# pelda1 "../out/Barri - Piter_Pen k__5p.shuff_part1.s" -> 5.5
# pelda2 "../out/Barri - Piter_Pen k__11.shuff_part1.s" -> 11
# pelda3 "../out/Barri - Piter_Pen k_5.shuff_part1.s" -> -1
def calc_class(filename):
    # Use a regular expression to find the number after "__"
    match = re.search(r'__([0-9]+)(p)?', filename)
    if match:
        number = int(match.group(1))  # Get the main number
        if match.group(2) == 'p':  # Check if "p" follows the number
            return number + 0.5  # Add 0.5 if "p" is present
        return number
    else:
        return -1  # Default value when no "__" and number is found


# 6-7 - leggyakoribb szavak szolistarol szazalekban
def filter_words(text_words, list_words):
    text_words = text_words.split("\n")
    list_words_set = set(list_words.split("\n"))
    in_words = 0
    out_words = 0
    for w in text_words:
        if w == "":
            continue
        if w in list_words_set:
            in_words += 1
        else:
            out_words += 1
    total = in_words + out_words
    return round(100 * round(out_words / total, 4), 2)


def write_to_file_and_stdout(file, message):
    file.write(message)
    print(message, end="")
