# 3-input Full Adder

# How it works

This project implements a one-bit combinational full adder.

It adds three one-bit input values:

- `ui_in[0]`: A
- `ui_in[1]`: B
- `ui_in[2]`: Cin

The circuit produces two outputs:

- `uo_out[0]`: Sum
- `uo_out[1]`: Cout

The Boolean equations are:

Sum = A XOR B XOR Cin

Cout = (A AND B) OR (A AND Cin) OR (B AND Cin)

The design is purely combinational. Therefore, the clock and reset
signals are not used.

# How to test

Set the input values using `ui_in[2:0]`:

- Set `ui_in[0]` to A.
- Set `ui_in[1]` to B.
- Set `ui_in[2]` to Cin.

Read the results from:

- `uo_out[0]` for Sum.
- `uo_out[1]` for Cout.

Use the following truth table:

| A | B | Cin | Sum | Cout |
|---|---|-----|-----|------|
| 0 | 0 | 0   | 0   | 0    |
| 0 | 0 | 1   | 1   | 0    |
| 0 | 1 | 0   | 1   | 0    |
| 0 | 1 | 1   | 0   | 1    |
| 1 | 0 | 0   | 1   | 0    |
| 1 | 0 | 1   | 0   | 1    |
| 1 | 1 | 0   | 0   | 1    |
| 1 | 1 | 1   | 1   | 1    |

No external hardware is required.
