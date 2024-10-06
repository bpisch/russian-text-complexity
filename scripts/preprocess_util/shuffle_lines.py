import argparse
import random

def shuffle_file(input_file, output_file):
    # Open the input file and read all lines
    with open(input_file, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    # Shuffle the order of the lines
    random.shuffle(lines)

    # Write the shuffled lines to the output file with Linux-style newlines
    with open(output_file, 'wb') as file:
        # Encode each line with UTF-8 and ensure it ends with '\n' (Linux-style newline)
        file.writelines(line.encode('utf-8') if line.endswith('\n') else (line + '\n').encode('utf-8') for line in lines)

if __name__ == "__main__":
    # Argument parser
    parser = argparse.ArgumentParser(description="Shuffle lines in a text file.")
    parser.add_argument("input", help="Input text file")
    parser.add_argument("output", help="Output text file")
    
    args = parser.parse_args()

    # Call the function to process the file
    shuffle_file(args.input, args.output)
