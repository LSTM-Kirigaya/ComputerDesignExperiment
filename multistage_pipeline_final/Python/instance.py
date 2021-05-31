import os

def get_instance(file : str):
    input_signals = []
    output_signals = []
    max_signal_length = 0
    for line in open(file, "r", encoding="utf-8"):
        line = line.strip().replace(",", "").replace(";", "")
        if len(line) == 0:
            continue
        metas = line.split()
        if "input" in metas:
            signal = metas[-1]
            max_signal_length = max(max_signal_length, len(signal))
            input_signals.append(input_signals)
        if "output" in metas:
            signal = metas[-1]
            max_signal_length = max(max_signal_length, signal)
            output_signals.append(signal)
    
    