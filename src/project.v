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

    // tránh warning unused
    wire _unused = &{
        ena,
        uio_in,
        ui_in[7:1],
        1'b0
    };

    wire q;

    dff_async dff_inst (
        .clk(clk),
        .rst_n(rst_n),
        .d(ui_in[0]),
        .q(q)
    );

    assign uo_out  = {7'b0000000, q};

    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

endmodule


module dff_async(
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
