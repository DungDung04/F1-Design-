import cocotb
from cocotb.triggers import ClockCycles, Timer
from cocotb.clock import Clock

@cocotb.test()
async def test_dff_async(dut):
    dut._log.info("Bắt đầu khởi chạy testbench mạch D Flip-Flop bất đồng bộ...")

    # Thiết lập giá trị tĩnh ban đầu để chống trạng thái không xác định (X)
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.ena.value = 1
    dut.clk.value = 0
    dut.rst_n.value = 0  # Bật reset mức thấp

    # Khởi động nguồn phát xung nhịp hệ thống chu kỳ 20ns
    cocotb.start_soon(Clock(dut.clk, 20, units="ns").start())
    await Timer(5, units="ns")

    # Kiểm tra xem uo_out[0] đã được reset về mức thấp 0 hay chưa
    assert (int(dut.uo_out.value) & 0x01) == 0, "Lỗi: Mạch không tự động reset về 0!"

    # Giải phóng chân reset
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)

    # Thử nghiệm chốt dữ liệu D = 1 sang Q
    dut.ui_in.value = 1  
    await ClockCycles(dut.clk, 1)  
    assert (int(dut.uo_out.value) & 0x01) == 1, "Lỗi: Dữ liệu D=1 không được chốt sang Q!"

    # Thử nghiệm chốt dữ liệu D = 0 sang Q
    dut.ui_in.value = 0  
    await ClockCycles(dut.clk, 1)  
    assert (int(dut.uo_out.value) & 0x01) == 0, "Lỗi: Dữ liệu D=0 không được chốt sang Q!"

    # Thử nghiệm bấm nút reset bất ngờ giữa chu kỳ xung nhịp
    dut.ui_in.value = 1
    await ClockCycles(dut.clk, 1)
    await Timer(5, units="ns")  
    
    dut.rst_n.value = 0  # Kích hoạt nút reset khẩn cấp bất đồng bộ
    await Timer(1, units="ns")  
    assert (int(dut.uo_out.value) & 0x01) == 0, "Lỗi: Đầu ra không chịu xóa trạng thái ngay lập tức!"

    dut._log.info("Mạch hoạt động hoàn toàn chính xác!")
