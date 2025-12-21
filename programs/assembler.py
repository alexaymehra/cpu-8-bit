import os

OPCODES = {
    "ADD": "000", "AND": "001", "NOT": "010",
    "LOAD": "011", "STORE": "100", "JUMP": "101",
    "JUMPZ": "110", "HALT": "111"
}

REGS = {"A": "0", "B": "1"}

def assemble(input_file, output_file):
    # Check if the input file exists to avoid a crash
    if not os.path.exists(input_file):
        print(f"Error: The file '{input_file}' was not found.")
        return

    # open input file as f_in in read mode, and output file as f_out in write mode
    with open(input_file, 'r') as f_in, open(output_file, 'w') as f_out:
        for line in f_in:
            # 1. Strip the part after ';' (if any) and handle inline comments
            content = line.split(';')[0]
            
            # 2. Tokenizer: splits the remaining content into a list
            tokens = content.replace(',', ' ').split() 
            
            # 3. If the line was only a comment or was empty, skip it
            if not tokens: 
                continue

            # identify instruction
            instr = tokens[0].upper()
            binary = ""

            try:
                # create HALT binary
                if instr == "HALT":
                    binary = "11111111"

                # create ADD or AND binary
                elif instr in ["ADD", "AND"]:
                    dr = REGS[tokens[1].upper()]
                    sr1 = REGS[tokens[2].upper()]
                    sr2 = REGS[tokens[3].upper()]
                    binary = f"{OPCODES[instr]}{dr}{sr1}{sr2}00"

                # create NOT binary
                elif instr == "NOT":
                    dr = REGS[tokens[1].upper()]
                    sr = REGS[tokens[2].upper()]
                    binary = f"{OPCODES[instr]}{dr}{sr}000"

                # create LOAD or STORE binary
                elif instr in ["LOAD", "STORE"]:
                    reg = REGS[tokens[1].upper()]
                    offset_bin = tokens[2] 
                    binary = f"{OPCODES[instr]}{reg}{offset_bin}"

                # create JUMP or JUMPz binary
                elif instr in ["JUMP", "JUMPZ"]:
                    baser = REGS[tokens[1].upper()]
                    binary = f"{OPCODES[instr]}{baser}0000"

                # if an instruction was created
                if binary:
                    if len(binary) != 8:
                        print(f"Warning: Line '{line.strip()}' resulted in {len(binary)} bits: {binary}")
                    f_out.write(f"{binary}    // {content.strip()}\n")
            
            except (IndexError, KeyError) as e:
                print(f"Error parsing line: {line.strip()} - Missing or invalid {e}")

# --- Main Entry Point ---
# When this file is run directly (python3 assembler.py), the condition is true
if __name__ == "__main__":
    # Get filenames from the user
    user_input = input("Enter the name of your assembly file (e.g., program.txt): ")
    user_output = input("Enter the desired name for the output file (e.g., program.b): ")

    assemble(user_input, user_output)
    print(f"\nTask complete! If no errors were shown, '{user_output}' is ready.")