# D Flip-Flop with Asynchronous Reset

## Overview

This project implements a **positive-edge triggered D Flip-Flop with an active-low asynchronous reset** for the Tiny Tapeout F1-Design competition.

The circuit captures the input data (`D`) on the rising edge of the clock (`CLK`). Whenever the reset signal (`RST_N`) is asserted low, the output (`Q`) is immediately cleared to logic 0 regardless of the clock.

---

## Features

- Positive-edge triggered D Flip-Flop
- Active-low asynchronous reset
- One-bit data storage
- Synthesizable Verilog HDL
- Cocotb verification
- Tiny Tapeout compatible

---

## Pin Description

| Signal | Direction | Description |
|---------|-----------|-------------|
| `clk` | Input | System clock |
| `rst_n` | Input | Active-low asynchronous reset |
| `ui_in[0]` | Input | Data input (D) |
| `uo_out[0]` | Output | Flip-Flop output (Q) |

All other I/O pins are unused.

---

## Operation

### Reset

If `rst_n = 0`

```
Q = 0
```

This happens immediately without waiting for a clock edge.

### Normal Operation

At every rising edge of the clock:

```
Q <= D
```

---

## Truth Table

| rst_n | Clock | D | Q(next) |
|-------|-------|---|---------|
| 0 | X | X | 0 |
| 1 | Rising Edge | 0 | 0 |
| 1 | Rising Edge | 1 | 1 |
| 1 | No Edge | X | Hold |

---

## Project Structure

```
F1-Design/
│
├── docs/
│   └── info.md
│
├── src/
│   ├── config.json
│   └── project.v
│
├── test/
│   ├── Makefile
│   ├── tb.v
│   ├── test.py
│   └── requirements.txt
│
├── info.yaml
├── README.md
└── LICENSE
```

---

## Verification

The design is verified using Cocotb.

The following tests are included:

- Initial reset
- D = 0 capture
- D = 1 capture
- Positive-edge triggering
- Asynchronous reset
- Output verification

---

## Development Tools

- Verilog HDL
- Cocotb
- Icarus Verilog
- GTKWave
- GitHub Actions
- Tiny Tapeout F1 Design
- KLayout

---

## Author

**DungDung04**

Project:
**D Flip-Flop with Asynchronous Reset**

Tiny Tapeout F1-Design
