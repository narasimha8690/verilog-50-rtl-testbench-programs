module traffic_light_fsm (
    input wire clk,
    input wire rst_n,  // active-low reset
    output reg red,
    output reg yellow,
    output reg green);

    typedef enum logic [1:0] {
        RED    = 2'b00,
        GREEN  = 2'b01,
        YELLOW = 2'b10
    } state_t;

    state_t current_state, next_state;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= RED;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            RED:    next_state = GREEN;
            GREEN:  next_state = YELLOW;
            YELLOW: next_state = RED;
            default: next_state = RED;
        endcase
    end

    always @(*) begin
        red    = 0;
        yellow = 0;
        green  = 0;
        case (current_state)
            RED:    red    = 1;
            GREEN:  green  = 1;
            YELLOW: yellow = 1;
        endcase
    end
endmodule

//Test Bench

module traffic_light_fsm_tb;

    reg clk;
    reg rst_n;
    wire red, yellow, green;

    traffic_light_fsm uut (
        .clk(clk),
        .rst_n(rst_n),
        .red(red),
        .yellow(yellow),
        .green(green));

    always #5 clk = ~clk;

    initial begin
        $display("Starting Traffic Light FSM Test");
        clk = 0;
        rst_n = 0;

        #10 rst_n = 1;

        #100 $finish;
    end

    initial begin
        $monitor("Time=%0t | RED=%b YELLOW=%b GREEN=%b", $time, red, yellow, green);
    end
endmodule
