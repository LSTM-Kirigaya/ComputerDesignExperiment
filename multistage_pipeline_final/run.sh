#!/bin/bash
iverilog -T min -o ./sim/testBench.v.out ./sim/testBench.v
vvp ./sim/testBench.v.out