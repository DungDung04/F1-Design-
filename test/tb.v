`default_nettype none
`timescale 1ns/1ps

/*
  File testbench Verilog bọc ngoài (Wrapper) cho mạch giải mã LED 7 đoạn.
  Kết nối trực tiếp các chân tín hiệu mô phỏng của cocotb vào module thiết kế chính.
*/
module tb (
    // Kết nối các chân I/O tiêu chuẩn từ môi trường kiểm thử cocotb
    input wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input wire clk,
    input wire rst_n
);

    // Cấu hình lưu file sóng tín hiệu để mở bằng GTKWave hoặc Surfer
    initial begin
        $dumpfile("tb.vcd"); // Đổi thành "tb.fst" nếu muốn lưu định dạng nén fst
        $dumpvars(0, tb);
        #1;
    end

    // Khởi tạo module chính (DUT - Device Under Test) của dự án giải mã LED 7 đoạn
    tt_um_nguyenvandongsn97_7seg_decoder user_project (
`ifdef GL_TEST
        // Kết nối các chân nguồn giả lập nếu chạy kiểm thử mức cổng (Gate-Level Simulation)
        .VPWR(1'b1),
        .VGND(1'b0),
`endif
        .ui_in   (ui_in),   // Kết nối các chân đầu vào switch
        .uo_out  (uo_out),  // Kết nối các chân điều khiển LED 7 đoạn
        .uio_in  (uio_in),  // Không dùng
        .uio_out (uio_out), // Trả về 0
        .uio_oe  (uio_oe),  // Trả về 0
        .clk     (clk),     // Không dùng nhưng bắt buộc kết nối chân
        .rst_n   (rst_n)    // Không dùng nhưng bắt buộc kết nối chân
    );

endmodule
