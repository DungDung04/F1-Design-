import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_7seg(dut):
    dut._log.info("Bắt đầu test mạch giải mã 7 đoạn...")

    # Test thử số 0 (Kỳ vọng đầu ra: g=1, f=0, e=0, d=0, c=0, b=0, a=0 -> 7'b1000000 -> Thập phân là 64)
    dut.ui_in.value = 0
    await Timer(1, units="ns")
    assert dut.uo_out.value & 0x7F == 64

    # Test thử số 8 (Kỳ vọng đầu ra sáng hết: 7'b0000000 -> 0)
    dut.ui_in.value = 8
    await Timer(1, units="ns")
    assert dut.uo_out.value & 0x7F == 0

    dut._log.info("Mạch hoạt động chính xác!")
