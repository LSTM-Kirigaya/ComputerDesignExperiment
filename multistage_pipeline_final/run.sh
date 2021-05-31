#!/bin/bash
iverilog -o ./sim/testBench.v.out ./sim/testBench.v
vvp ./sim/testBench.v.out