`default_nettype none

module tt_um_nguyenvandongsn97_7seg_decoder (
    input  wire [7:0] ui_in,    // Các chân đầu vào (chỉ dùng ui_in[3:0])
    output wire [7:0] uo_out,   // Các chân đầu ra (chỉ dùng uo_out[6:0])
    input  wire [7:0] uio_in,   // Không dùng trong dự án này
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       clk,      // Không dùng vì là mạch tổ hợp
    input  wire       rst_n     // Không dùng
);

    // Gán các chân uio không dùng về trạng thái an toàn (đầu vào, mức thấp)
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;
    assign uo_out[7] = 1'b0; // Chân dư của đầu ra gán bằng 0

    // Đặt tên gợi nhớ cho đầu vào 4-bit (giá trị từ 0 đến 15)
    wire [3:0] bcd = ui_in[3:0];
    reg [6:0] led_out;

    // Ánh xạ đầu ra ra các chân uo_out
    // uo_out[0]=a, [1]=b, [2]=c, [3]=d, [4]=e, [5]=f, [6]=g
    assign uo_out[6:0] = led_out;

    always @(*) begin
        case (bcd)
            // Cấu trúc bit: g f e d c b a (Mức 0 = Sáng, Mức 1 = Tắt)
            4'h0: led_out = 7'b1000000; // Hiển thị số 0
            4'h1: led_out = 7'b1111001; // Hiển thị số 1
            4'h2: led_out = 7'b0100100; // Hiển thị số 2
            4'h3: led_out = 7'b0110000; // Hiển thị số 3
            4'h4: led_out = 7'b0011001; // Hiển thị số 4
            4'h5: led_out = 7'b0010010; // Hiển thị số 5
            4'h6: led_out = 7'b0000010; // Hiển thị số 6
            4'h7: led_out = 7'b1111000; // Hiển thị số 7
            4'h8: led_out = 7'b0000000; // Hiển thị số 8
            4'h9: led_out = 7'b0010000; // Hiển thị số 9
            4'hA: led_out = 7'b0001000; // Hiển thị chữ A
            4'hB: led_out = 7'b0000011; // Hiển thị chữ b
            4'hC: led_out = 7'b1000110; // Hiển thị chữ C
            4'hD: led_out = 7'b0100001; // Hiển thị chữ d
            4'hE: led_out = 7'b0000110; // Hiển thị chữ E
            4'hF: led_out = 7'b0001110; // Hiển thị chữ F
            default: led_out = 7'b1111111; // Tắt hết đèn nếu lỗi
        endcase
    end

endmodule
