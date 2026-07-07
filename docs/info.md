## How it works

This project implements a standard 1-bit D Flip-Flop (DFF) featuring an active-low asynchronous reset pin. It is a fundamental sequential logic building block designed for the Tiny Tapeout platform.

The circuit captures the data input value from the LSB of `ui_in` (`ui_in[0]`) and transfers it to the LSB of `uo_out` (`uo_out[0]`) on every positive edge (rising edge) of the system clock (`clk`). 

### Asynchronous Reset Behavior
Unlike a synchronous design, the reset operation does not wait for a clock edge:
- When the reset pin `rst_n` goes low (`0`), the output state register is cleared to `0` **immediately**, overriding any input signal on the clock or data lines.
- Normal data latching resumes only after `rst_n` returns to a high logic level (`1`).

All unused input/output ports and bidirectional `uio` pins are safely driven to ground (`0`) within the hardware to prevent floating nets and satisfy strict linting requirements.

## How to test

The project includes an automated Python testbench utilizing `cocotb` to simulate both synchronous state loading and asynchronous clearing events.

### Manual Verification Steps
1. Connect `ui_in[0]` to an input switch (this acts as your **D Input** data line).
2. Connect `uo_out[0]` to an external monitoring LED (this acts as your **Q Output** state line).
3. Connect `rst_n` to a reset toggle switch (Active-low, keep it at `1` for normal operation).
4. Apply a steady clock signal to the `clk` pin.
5. **Test Data Latching**: Change the state of the switch `ui_in[0]` and observe that the LED on `uo_out[0]` only updates its state at the exact moment the clock completes a transition from low to high.
6. **Test Asynchronous Reset**: While the LED is active (`1`), flip the `rst_n` switch to `0`. The LED should turn OFF instantly, regardless of the clock's current state or phase.

## External hardware

- **Clock Source**: A steady digital square-wave clock signal (configured for up to 10 MHz in static timing analysis).
- **Switches & Pulldowns**: Standard mechanical toggle switches or push buttons connected to inputs with appropriate pulldown resistors.
- **Status Indicator**: 1x LED connected to `uo_out[0]` via a current-limiting resistor ($220\Omega$ to $330\Omega$) to display the output bit state.
