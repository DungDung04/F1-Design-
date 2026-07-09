# D Flip-Flop with Asynchronous Reset

## Project Overview

This project implements a **positive-edge triggered D Flip-Flop with an active-low asynchronous reset**.

The circuit stores the input data (`D`) on the rising edge of the clock (`CLK`). When the asynchronous reset (`RST_N`) is asserted low, the output (`Q`) is immediately cleared to logic `0` regardless of the clock state.

This design demonstrates one of the most fundamental sequential logic elements used in digital integrated circuits.

---

## Features

- Positive-edge triggered D Flip-Flop
- Active-low asynchronous reset
- One-bit data storage
- Fully synthesizable Verilog RTL
- Compatible with Tiny Tapeout F1 Design flow
- Verified using Cocotb testbench

---

## Pin Assignment

| Signal | Direction | Description |
|---------|-----------|-------------|
| CLK | Input | System clock |
| RST_N | Input | Active-low asynchronous reset |
| D | Input | Data input |
| Q | Output | Flip-Flop output |

---

## Operation

| CLK | RST_N | D | Q |
|-----|--------|---|---|
| ↑ | 1 | 0 | 0 |
| ↑ | 1 | 1 | 1 |
| X | 0 | X | 0 |

- On every rising edge of the clock, `Q` follows `D`.
- When `RST_N = 0`, `Q` is immediately reset to `0`, independent of the clock.

---

## Truth Table

| RST_N | Clock | D | Q(next) |
|--------|-------|---|---------|
| 0 | X | X | 0 |
| 1 | Rising Edge | 0 | 0 |
| 1 | Rising Edge | 1 | 1 |
| 1 | No Edge | X | Hold |

---

## RTL Description

The flip-flop is implemented using a single sequential always block:

```verilog
always @(posedge clk or negedge rst_n)
begin
    if (!rst_n)
        q <= 1'b0;
    else
        q <= d;
end
