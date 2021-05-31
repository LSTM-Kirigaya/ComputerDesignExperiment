def get_8k_data(file):
    with open(file, "w", encoding="utf-8") as f:
        for _ in range(2048):
            f.write("00000000\n")

get_8k_data("./data/r_data")