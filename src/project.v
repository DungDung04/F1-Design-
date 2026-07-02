`default_nettype none

module tt_um_nguyenvandongsn97_7seg_decoder (
    input  wire [7:0] ui_in,    // Các chân đầu vào chuyên dụng (Chỉ dùng ui_in[3:0] cho BCD)
    output wire [7:0] uo_out,   // Các chân đầu ra chuyên dụng (Chỉ dùng uo_out[6:0] cho LED)
    input  wire [7:0] uio_in,   // Các chân đầu vào/ra hai chiều (Không dùng)
    output wire [7:0] uio_out,  // Đầu ra cho các chân hai chiều (Đặt bằng 0)
    output wire [7:0] uio_oe,   // Chân cho phép xuất dữ liệu điều khiển uio (Đặt bằng 0 = Input)
    input  wire       clk,      // Xung nhịp hệ thống (Không dùng trong mạch tổ hợp)
    input  wire       rst_n     // Chân Reset tích cực mức thấp (Không dùng)
);

    // 1. Quản lý các chân không sử dụng để tránh lỗi Floating/Trạng thái lơ lửng trên chip
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;
    
    // Chân đầu ra uo_out[7] không dùng để điều khiển LED nên gán cố định về 0
    assign uo_out[7] = 1'b0; 

    // 2. Trích xuất dữ liệu đầu vào và khai báo thanh ghi lưu trạng thái LED
    wire [3:0] bcd = ui_in[3:0]; // Nhận giá trị số từ 4 switch đầu vào (0 đến 15)
    reg [6:0] led_out;           // Lưu trạng thái của 7 phân đoạn (g, f, e, d, c, b, a)

    // Ánh xạ trực tiếp 7 bit kết quả vào các chân đầu ra uo_out[6:0]
    assign uo_out[6:0] = led_out;

    // 3. Khối mạch tổ hợp giải mã hiển thị ký tự Hex (0-9, A-F)
    // Lưu ý: Cấu hình dành cho LED Anode chung (Mức 0 = Sáng, Mức 1 = Tắt)
    always @(*) begin
        case (bcd)
            // Định dạng chuỗi bit: g-f-e-d-c-b-a
            4'h0: led_out = 7'b1000000; // Số 0 (Tắt thanh g)
            4'h1: led_out = 7'b1111001; // Số 1 (Sáng b, c)
            4'h2: led_out = 7'b0100100; // Số 2 (Tắt f, c)
            4'h3: led_out = 7'b0110000; // Số 3 (Tắt f, e)
            4'h4: led_out = 7'b0011001; // Số 4 (Tắt a, d, e)
            4'h5: led_out = 7'b0010010; // Số 5 (Tắt b, e)
            4'h6: led_out = 7'b0000010; // Số 6 (Tắt b)
            4'h7: led_out = 7'b1111000; // Số 7 (Sáng a, b, c)
            4'h8: led_out = 7'b0000000; // Số 8 (Sáng tất cả các thanh)
            4'h9: led_out = 7'b0010000; // Số 9 (Tắt thanh e)
            4'hA: led_out = 7'b0001000; // Chữ A (Tắt thanh d)
            4'hB: led_out = 7'b0000011; // Chữ b (Tắt a, b)
            4'hC: led_out = 7'b1000110; // Chữ C (Tắt b, c, g)
            4'hD: led_out = 7'b0100001; // Chữ d (Tắt a, f)
            4'hE: led_out = 7'b0000110; // Chữ E (Tắt b, c)
            4'hF: led_out = 7'b0001110; // Chữ F (Tắt b, c, d)
            default: led_out = 7'b1111111; // Trường hợp lỗi: Tắt toàn bộ LED
        endcase
    end

endmodule
