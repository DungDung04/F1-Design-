import cocotb
from cocotb.triggers import ClockCycles, Timer
from cocotb.clock import Clock  # BẮT BUỘC PHẢI CÓ DÒNG NÀY ĐỂ CHẠY MẠCH TUẦN TỰ

@cocotb.test()
async def test_dff_async(dut):
    dut._log.info("Bắt đầu khởi chạy testbench mạch D Flip-Flop bất đồng bộ...")

    # Khởi tạo toàn bộ giá trị ban đầu cho các cổng để tránh trạng thái X (Undefined)
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.ena.value = 1
    dut.clk.value = 0
    dut.rst_n.value = 0  # Kích hoạt reset ban đầu

    # 1. Khởi động bộ tạo xung nhịp hệ thống (Chu kỳ 20ns = 50MHz)
    cocotb.start_soon(Clock(dut.clk, 20, units="ns").start())
    await Timer(5, units="ns")

    # Kiểm tra xem đầu ra Q (uo_out[0]) đã được reset về 0 chưa
    assert (int(dut.uo_out.value) & 0x01) == 0, "Lỗi: Mạch không tự động reset về 0!"

    # 2. Tháo bỏ trạng thái Reset bất đồng bộ
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)

    # 3. Kiểm tra chốt dữ liệu mức 1 (D = 1)
    dut.ui_in.value = 1  # D = 1
    await ClockCycles(dut.clk, 1)  # Chờ đến cạnh lên kế tiếp
    assert (int(dut.uo_out.value) & 0x01) == 1, "Lỗi: Dữ liệu D=1 không được chốt sang Q!"

    # 4. Kiểm tra chốt dữ liệu mức 0 (D = 0)
    dut.ui_in.value = 0  # D = 0
    await ClockCycles(dut.clk, 1)  # Chờ đến cạnh lên kế tiếp
    assert (int(dut.uo_out.value) & 0x01) == 0, "Lỗi: Dữ liệu D=0 không được chốt sang Q!"

    # 5. Kiểm tra tính năng Reset bất đồng bộ khẩn cấp giữa chu kỳ clock
    dut.ui_in.value = 1
    await ClockCycles(dut.clk, 1)
    await Timer(5, units="ns")  // Đợi lơ lửng ở giữa chu kỳ
    
    dut.rst_n.value = 0  # Bấm nút reset khẩn cấp
    await Timer(1, units="ns")  // Kiểm tra ngay lập tức mà không đợi clock
    assert (int(dut.uo_out.value) & 0x01) == 0, "Lỗi: Reset bất đồng bộ thất bại khi đang chạy!"

    dut._log.info("Chúc mừng! Mạch DFF Asynchronous Reset đã vượt qua toàn bộ kiểm thử!")
