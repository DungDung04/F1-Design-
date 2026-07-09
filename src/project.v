`default_nettype none

module tt_um_nguyentrungdung04_dff_async (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input  wire ena,
    input  wire clk,
    input  wire rst_n
);

    // Không sử dụng các chân này nhưng vẫn khai báo để tránh warning
    wire _unused = &{ena, uio_in};

    // D input
    wire d = ui_in[0];

    // Q output
    wire q;

    // D Flip-Flop with Asynchronous Active-Low Reset
    dff_async u_dff (
        .clk(clk),
        .rst_n(rst_n),
        .d(d),
        .q(q)
    );

    // Chỉ sử dụng uo_out[0]
    assign uo_out = {7'b0000000, q};

    // Không sử dụng GPIO hai chiều
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

endmodule


module dff_async (
    input  wire clk,
    input  wire rst_n,
    input  wire d,
    output reg  q
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule

`default_nettype wire
