module axi_to_apb_bridge (
    input wire        ACLK,
    input wire        ARESETn,

    input wire [31:0] AWADDR,
    input wire        AWVALID,
    output reg        AWREADY,

    
    input wire [31:0] WDATA,
    input wire [3:0]  WSTRB,
    input wire        WVALID,
    output reg        WREADY,


    output reg [1:0]  BRESP,
    output reg        BVALID,
    input wire        BREADY,


    input wire [31:0] ARADDR,
    input wire        ARVALID,
    output reg        ARREADY,


    output reg [31:0] RDATA,
    output reg [1:0]  RRESP,
    output reg        RVALID,
    input wire        RREADY,

    
    output reg        PSEL,
    output reg        PENABLE,
    output reg [31:0] PADDR,
    output reg        PWRITE,
    output reg [31:0] PWDATA,
    input  wire [31:0] PRDATA,
    input  wire        PREADY,
    input  wire        PSLVERR
);

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        SETUP = 2'b01,
        ACCESS = 2'b10
    } apb_state_t;

    apb_state_t state, next_state;

    always @(posedge ACLK or negedge ARESETn) begin
        if (!ARESETn)
            state <= IDLE;
        else
            state <= next_state;
    end
    always @(*) begin
        next_state = state;
        case (state)
            IDLE:   if (AWVALID && WVALID) next_state = SETUP;
            SETUP:  next_state = ACCESS;
            ACCESS: if (PREADY) next_state = IDLE;
        endcase
    end

    always @(posedge ACLK or negedge ARESETn) begin
        if (!ARESETn) begin
            PSEL    <= 0;
            PENABLE <= 0;
            PWRITE  <= 0;
            PADDR   <= 0;
            PWDATA  <= 0;
            AWREADY <= 0;
            WREADY  <= 0;
            BVALID  <= 0;
            BRESP   <= 2'b00;
        end else begin
            case (state)
                IDLE: begin
                    PSEL    <= 0;
                    PENABLE <= 0;
                    AWREADY <= 1;
                    WREADY  <= 1;
                    BVALID  <= 0;
                end
                SETUP: begin
                    PSEL    <= 1;
                    PENABLE <= 0;
                    PWRITE  <= 1;
                    PADDR   <= AWADDR;
                    PWDATA  <= WDATA;
                    AWREADY <= 0;
                    WREADY  <= 0;
                end
                ACCESS: begin
                    PENABLE <= 1;
                    if (PREADY) begin
                        PSEL   <= 0;
                        PENABLE <= 0;
                        BVALID <= 1;
                        BRESP  <= (PSLVERR) ? 2'b10 : 2'b00; 
                    end
                end
            endcase
            if (BREADY)
                BVALID <= 0;
        end
    end
    always @(posedge ACLK or negedge ARESETn) begin
        if (!ARESETn) begin
            ARREADY <= 0;
            RVALID  <= 0;
            RDATA   <= 0;
            RRESP   <= 2'b00;
        end else begin
            ARREADY <= 1'b0;
            RVALID  <= 1'b0;
        end
    end

endmodule
