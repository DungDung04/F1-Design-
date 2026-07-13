import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer

@cocotb.test()
async def test_dff_async(dut):

    cocotb.start_soon(Clock(dut.clk, 20, units="ns").start())

    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0

    # Chờ reset bất đồng bộ có hiệu lực
    await Timer(2, units="ns")

    assert dut.uo_out.value.integer == 0

    # Nhả reset
    dut.rst_n.value = 1

    await ClockCycles(dut.clk, 1)
    await Timer(1, units="ns")

    # Ghi D=1
    dut.ui_in.value = 1

    await ClockCycles(dut.clk, 1)
    await Timer(1, units="ns")

    assert dut.uo_out.value.integer == 1

    # Ghi D=0
    dut.ui_in.value = 0

    await ClockCycles(dut.clk, 1)
    await Timer(1, units="ns")

    assert dut.uo_out.value.integer == 0

    # Test reset bất đồng bộ
    dut.ui_in.value = 1

    await ClockCycles(dut.clk, 1)
    await Timer(1, units="ns")

    dut.rst_n.value = 0

    await Timer(1, units="ns")

    assert dut.uo_out.value.integer == 0
