from pprint import pprint

def get_assign_array(verilog_file : str):
    input_signals = []
    max_output_length = 0
    output_signals = []
    for line in open(verilog_file, "r", encoding="utf-8"):
        line = line.strip()
        if "clock" in line or "reset" in line:
            continue
        if "input" in line:
            line = line.replace(",", "").split()[-1]
            input_signals.append(line)
        if "output" in line:
            line = line.replace(",", "").split()[-1]
            output_signals.append(line)
            max_output_length = max(max_output_length, len(line))
        if ");" in line:
            break
    
    assign_array = [f"{o}{(max_output_length - len(o)) * ' '} <=   {i};" for i, o in zip(input_signals, output_signals)]
    print("\talways @(posedge clock) begin")
    for line in assign_array:
        print("\t\t" + line)
    print("\tend")

get_assign_array("./src/Pipe/MEM_WB.v")