# Cocotb Testbench

This directory contains the verification environment for the
D Flip-Flop with Asynchronous Reset.

## Files

- test.py : Cocotb test
- tb.v : Top-level Verilog testbench
- tb.gtkw : GTKWave configuration
- Makefile : Cocotb build script

## Tested Features

- Initial reset
- Positive edge triggering
- D=0
- D=1
- Hold state
- Asynchronous reset
