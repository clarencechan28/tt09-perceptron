`default_nettype none

module perceptron (
    input  wire       clk,       // clock
    input  wire       reset,     // reset_n - low to reset
    input  wire[7:0]  in,        // perceptron inputs
    input  wire       exp_res,    // expected result
    output wire       result     // actual result of perceptron calculation
);
    reg[7:0] weights;
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

    assign net_input = in*wt; // multiply inputs with corresponding weights

endmodule
