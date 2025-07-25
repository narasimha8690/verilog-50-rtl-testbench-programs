module ahb_slave (
    input wire HCLK,
    input wire HRESETn,
    input wire HWRITE,
    input wire [1:0] HTRANS,
    input wire [31:0] HADDR,
    input wire [31:0] HWDATA,
    output reg [31:0] HRDATA,
    output reg HREADY);

reg [31:0] mem [0:255];

always @(posedge HCLK or negedge HRESETn) begin
    if (!HRESETn) begin
        HREADY <= 1'b0;
        HRDATA <= 32'd0;
    end else begin
        if (HTRANS == 2'b10 && HWRITE) begin
            mem[HADDR[9:2]] <= HWDATA;
            HREADY <= 1'b1;
        end else if (HTRANS == 2'b10 && !HWRITE) begin
            HRDATA <= mem[HADDR[9:2]];
            HREADY <= 1'b1;
        end else begin
            HREADY <= 1'b0;
        end
    end
end
endmodule
