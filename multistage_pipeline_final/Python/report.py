import os

def one_file_report(file : str):
    split_format = None
    if "/" in file:
        split_format = "/"
    if "\\" in file:
        split_format = "\\"
    file_name = file.split(split_format)[-1]
    print(f"### {file_name}")
    print("| 信号名 |  接口类型  | 接口位数 |  描述  |")
    print("| ---- | ---- | ---- | ---- |")
    module = "| {} | {} | {} |    |"
    for line in open(file, "r", encoding="utf-8"):
        line = line.strip().replace(",", "").replace(";", "")
        if "//" in line:
            line = line.split("//")[0]
        if ");" in line:
            return
        if "input" in line:
            signal_name = "`" + line.split()[-1] + "`"
            inter_type = "input"
            if "[" in line:
                left_index, right_index = line.index("["), line.index("]")
                bit_des = line[left_index : right_index + 1]
            else:
                bit_des = "[0]"
            print(module.format(signal_name, inter_type, bit_des))
        if "output" in line:
            signal_name = "`" + line.split()[-1] + "`"
            inter_type = "output"
            if "[" in line:
                left_index, right_index = line.index("["), line.index("]")
                bit_des = line[left_index : right_index + 1]
            else:
                bit_des = "[0]"
            print(module.format(signal_name, inter_type, bit_des))

# one_file_report("./src/DataPath/Utils/alu_ctrl.v")

# dir_name = "./src"
# for file_name in os.listdir(dir_name):
#     if file_name.endswith(".v"):
#         one_file_report(dir_name + "/" + file_name)
#         print("\n\n")


def signal_field(file : str):
    print("| 信号名 | 信号 |  描述  |")
    print("| ---- | ---- | ---- |")
    module = "| `{}` | {} |   |"
    for line in open(file, "r", encoding="utf-8"):
        line = line.strip().replace(",", "").replace(";", "")
        if len(line) == 0:
            continue
        line = line.split()
        print(module.format(line[1], line[3]))

signal_field("./Python/temp")