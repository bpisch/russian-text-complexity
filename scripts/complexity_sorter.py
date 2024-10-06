import argparse


def sort_values(input_file, output_file, sort_by):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    # Create a list of tuples with (value, line)
    lines_with_value = []
    for line in lines:
        # Split line and find the fkg and dc values
        parts = line.split()
        fkg_value = None
        dc_value = None
        dc_ext_value = None

        for part in parts:
            if part.startswith("fkg="):
                fkg_value = float(part.split('=')[1])  # Convert to float
            elif part.startswith("dc="):
                dc_value = float(part.split('=')[1])  # Convert to float
            elif part.startswith("dc_ext="):
                dc_ext_value = float(part.split('=')[1])  # Convert to float

        # Ensure at least one value is found
        if fkg_value is not None and dc_value is not None:
            if sort_by == 'fkg':
                lines_with_value.append((fkg_value, line.strip()))
            elif sort_by == 'dc':
                lines_with_value.append((dc_value, line.strip()))
            elif sort_by == 'dc_ext':
                lines_with_value.append((dc_ext_value, line.strip()))
            else:
                raise ValueError("sort_by must be either 'fkg' or 'dc' or 'dc_ext'")

    # Sort by the specified value
    sorted_lines = sorted(lines_with_value, key=lambda x: x[0])

    # Write sorted lines to the output file
    with open(output_file, 'w') as file:
        for _, line in sorted_lines:
            file.write(line + '\n')


def main():
    parser = argparse.ArgumentParser(description="Sort lines in a file by fkg or dc value.")
    parser.add_argument("input_file", help="The input file name to read from.")
    parser.add_argument("output_file", help="The output file name to write sorted lines to.")
    parser.add_argument("sort_by", choices=['fkg', 'dc', 'dc_ext'],
                        help="Specify 'fkg' or 'dc' or 'dc_ext' to sort by that value.")

    args = parser.parse_args()

    sort_values(args.input_file, args.output_file, args.sort_by)


if __name__ == "__main__":
    main()
