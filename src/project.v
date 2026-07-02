`default_nettype none

module tt_um_nguyenvandongsn97_7seg_decoder (
    input  wire [7:0] ui_in,    // Các chân đầu vào chuyên dụng (Chỉ dùng ui_in[3:0] cho BCD)
    output wire [7:0] uo_out,   // Các chân đầu ra chuyên dụng (Chỉ dùng uo_out[6:0] cho LED)
    input  wire [7:0] uio_in,   // Các chân đầu vào/ra hai chiều (Không dùng)
    output wire [7:0] uio_out,  // Đầu ra cho các chân hai chiều (Đặt bằng 0)
    output wire [7:0] uio_oe,   // Chân cho phép xuất dữ liệu điều khiển uio (Đặt bằng 0 = Input)
    input  wire       ena,      // Lệnh kích hoạt module từ Tiny Tapeout (Không dùng)
    input  wire       clk,      // Xung nhịp hệ thống (Không dùng trong mạch tổ hợp)
    input  wire       rst_n     // Chân Reset tích cực mức thấp (Không dùng)
);

    // Tắt cảnh báo tín hiệu không sử dụng từ Verilator
    /* verilator lint_off UNUSEDSIGNAL */

    // 1. Quản lý các chân uio không sử dụng
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;
    
    // 2. Trích xuất dữ liệu đầu vào và khai báo trạng thái LED
    wire [3:0] bcd = ui_in[3:0]; 
    reg [6:0] led_out;           

    // 3. Ánh xạ ĐỘC LẬP các bit của uo_out để tránh trùng lặp gán tín hiệu
    assign uo_out[6:0] = led_out;  // 7 bit đầu điều khiển thanh LED a->g
    assign uo_out[7]   = 1'b0;     // Chỉ gán riêng bit số 7 (không dùng) về 0

    // 4. Khối mạch tổ hợp giải mã hiển thị ký tự Hex (Common Anode)
    always @(*) begin
        case (bcd)
            // Định dạng chuỗi bit: g-f-e-d-c-b-a (0 = Sáng, 1 = Tắt)
            4'h0: led_out = 7'b1000000; // Số 0
            4'h1: led_out = 7'b1111001; // Số 1
            4'h2: led_out = 7'b0100100; // Số 2
            4'h3: led_out = 7'b0110000; // Số 3
            4'h4: led_out = 7'b0011001; // Số 4
            4'h5: led_out = 7'b0010010; // Số 5
            4'h6: led_out = 7'b0000010; // Số 6
            4'h7: led_out = 7'b1111000; // Số 7
            4'h8: led_out = 7'b0000000; // Số 8
            4'h9: led_out = 7'b0010000; // Số 9
            4'hA: led_out = 7'b0001000; // Chữ A
            4'hB: led_out = 7'b0000011; // Chữ b
            4'hC: led_out = 7'b1000110; // Chữ C
            4'hD: led_out = 7'b0100001; // Chữ d
            4'hE: led_out = 7'b0000110; // Chữ E
            4'hF: led_out = 7'b0001110; // Chữ F
            default: led_out = 7'b1111111; // Tắt toàn bộ LED nếu lỗi
        endcase
    end

    /* verilator lint_on UNUSEDSIGNAL */

endmodule
