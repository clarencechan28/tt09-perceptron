`default_nettype none

module perceptron (
    input  wire       clk,       // clock
    input  wire       reset,     // reset_n - low to reset
    input  wire[7:0]  in,        // perceptron inputs
    input  wire[7:0]  weights,   // input weights
    output wire  result     // actual result of perceptron calculation
);
    reg[7:0] net_input;
    reg[7:0] threshold;
    integer i;

    always @(posedge clk) begin
        if (!reset) begin
            net_input = 0;
            threshold <= 5;
        end else begin
            // evaluate perceptron
            for (i = 0; i < 8; i = i + 1) begin
                net_input = net_input + in[i] * weights[i]; // multiply inputs with corresponding weights
            end
        end
    end

    assign result = (net_input >= threshold);

endmodule
