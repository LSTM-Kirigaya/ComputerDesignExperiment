def generate_pipelie_output(file, pipeline_name):
    names = []
    for line in open(file, "r", encoding="utf-8"):
        if line.find("//") != -1:
            line = line[:line.find("//")]
        line = line.strip().replace(";", "").replace("input", "")
        if len(line) == 0:
            continue
        signal_name = line.split()[-1]
        line = line.replace(signal_name, pipeline_name + "_" + signal_name)
        print(f"output reg{line};")
        names.append((pipeline_name + "_" + signal_name, signal_name))
    
    
    max_length = max([len(tup[0]) for tup in names])
    print("\n" + 20 * "-" + "\n")
    for tup in names:
        print(f"{tup[0]}{(max_length - len(tup[0])) * ' '}  <=  {tup[1]};")

    print("\n" + 20 * "-" + "\n")
    for tup in names:
        print(tup[0] + ("" if tup == names[-1] else ","))


def pipeline_assign(file):
    lines = []
    for line in open(file, "r", encoding="utf-8"):
        line = line.strip().replace(";", "")
        lines.append(line)
    max_length = max(list(map(lambda x : len(x), lines)))
    for line in lines:
        target = "_".join(line.split("_")[2:])
        print(f"{line}{(max_length - len(line)) * ' '}  <=  {target};")

generate_pipelie_output("./Python/test.txt", "ID_EX")