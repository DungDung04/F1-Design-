`default_nettype none

module tt_um_nguyentrungdung04_dff_async (
    input  wire [7:0] ui_in,    // ui_in[0] đóng vai trò là đầu vào D
    output wire [7:0] uo_out,   // uo_out[0] đóng vai trò là đầu ra Q
    input  wire [7:0] uio_in,   // Các chân hai chiều không dùng
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   
    input  wire       ena,      // Chân enable từ Tiny Tapeout template
    input  wire       clk,      // Xung nhịp kích hoạt cạnh lên (Posedge Clock)
    input  wire       rst_n     // Chân Reset bất đồng bộ tích cực mức thấp
);

    // Tắt cảnh báo tín hiệu không sử dụng từ Verilator cho các chân dư
    /* verilator lint_off UNUSEDSIGNAL */

    // 1. Quản lý các chân uio và chân trống để tránh lỗi trạng thái lơ lửng
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;
    assign uo_out[7:1] = 7'b0000000; // Các chân đầu ra trống gán cố định về 0

    // Đầu vào D lấy từ chân ui_in[0]
    wire d_in = ui_in[0];
    reg  q_out;

    // Ánh xạ thanh ghi trạng thái ra chân đầu ra uo_out[0]
    assign uo_out[0] = q_out;

    // 2. Khối mạch tuần tự DFF kích hoạt bởi cạnh lên CLK hoặc cạnh xuống RST_N
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q_out <= 1'b0; // Reset bất đồng bộ: Đầu ra về 0 ngay khi rst_n = 0
        end else if (ena) begin
            q_out <= d_in; // Cập nhật dữ liệu từ D sang Q khi có cạnh lên clock
        end
    end

    /* verilator lint_on UNUSEDSIGNAL */

    // Giữ chân rác để linter không bắt lỗi
    wire _linter_clear = |{ui_in[7:1], uio_in};

endmodule
