`default_nettype none

module perceptron (
    input  wire       clk,       // clock
    input  wire       reset,     // reset_n - low to reset
    input  wire[7:0]  in,        // perceptron inputs
    input  wire       exp_res,    // expected result
    output wire       result     // actual result of perceptron calculation
);
    reg[63:0] weights;
    reg[15:0] act_thresh; // step function activation
    wire[15:0] net_input;
    reg error;

    always @(posedge clk) begin
        if (!reset) begin
            result <= 0;
            // SGD?
            act_thresh <= 7.5;
        end else begin
            result <= (net_input >= act_thresh); // evaluate perceptron
        end
    end

    integer i;

    for (i = 0; i < 8; i = i + 1) // based on 8 inputs
    begin
        integer w = 8 * i;
        net_input <= net_input + in[i] * weights[w+7:w]; // multiply inputs with corresponding weights
    end

endmodule
