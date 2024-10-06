import os
import sys

def split_file(input_file, num_parts):
    # Check if the input file exists
    if not os.path.isfile(input_file):
        print(f"File {input_file} does not exist.")
        return
    
    # Read all the lines from the file
    with open(input_file, 'r', encoding='utf-8') as file:
        lines = file.readlines()
    
    # Calculate the number of lines per part
    total_lines = len(lines)
    lines_per_part = total_lines // num_parts  # Integer division to determine lines per part
    extra_lines = total_lines % num_parts  # Remaining lines that will be distributed among the first parts
    
    # Split the file into parts
    start = 0
    for i in range(num_parts):
        # Each part may get one extra line if there are extra lines
        end = start + lines_per_part + (1 if i < extra_lines else 0)
        part_lines = lines[start:end]
        
        # Save the current part to a new file
        output_file = f"{input_file}_part{i+1}.txt"
        with open(output_file, 'w', encoding='utf-8') as part_file:
            part_file.writelines(part_lines)
        
        print(f"Created file: {output_file} with {len(part_lines)} lines.")
        
        start = end

if __name__ == "__main__":
    # Ensure the correct number of arguments are passed
    if len(sys.argv) != 3:
        print("Usage: python split_file.py <file_name> <num_parts>")
        sys.exit(1)
    
    # Get file name and number of parts from command line arguments
    input_file = sys.argv[1]
    num_parts = int(sys.argv[2])
    
    # Call the function to split the file
    split_file(input_file, num_parts)
