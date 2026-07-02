# Testbench for Tiny Tapeout 7-Segment Decoder Project

This testbench is configured to verify the behavior of the **BCD to 7-Segment LED Decoder** project using [cocotb](https://docs.cocotb.org/en/stable/). It drives the input pins with binary values (0-15) and validates the corresponding segment outputs.

## Setting up

Before running the simulation, ensure you have completed the setup steps required by the Tiny Tapeout template:

1. **Verify Makefile**: Confirm that `PROJECT_SOURCES = project.v` in your [Makefile](Makefile) points correctly to your Verilog source inside the `src/` directory.
2. **Update tb.v**: Open [tb.v](tb.v) and ensure that you have replaced the default template module instantiation with your custom top module name:  
   `tt_um_nguyenvandongsn97_7seg_decoder`

## How to run

To run the RTL simulation (pure functional logic verification):

```sh
make -B
```

To run the Gate-Level simulation (verifying the timing and behavior after the digital hardening process), first trigger your GDS flow, download/locate the synthesized netlist file, and save it as `gate_level_netlist.v` inside this test directory.

Then run:

```sh
make -B GATES=yes
```

### Waveform Configuration
By default, the simulation captures signal transactions in the compact FST format. If you prefer to generate a standard VCD file instead, edit [tb.v](tb.v) to use `$dumpfile("tb.vcd");` and execute:

```sh
make -B FST=
```

This will output a `tb.vcd` file instead of `tb.fst`.

## How to view the waveform file

### Using GTKWave
To inspect input switches (`ui_in`) and segment drivers (`uo_out`) over time:

```sh
gtkwave tb.fst tb.gtkw
```

### Using Surfer
A modern alternative web/terminal waveform viewer:

```sh
surfer tb.fst
```
