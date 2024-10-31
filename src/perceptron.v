`default_nettype none

module perceptron (
    input  wire       clk,       // clock
    input  wire       reset,     // reset_n - low to reset
    input  wire[7:0]  in,        // perceptron inputs
    input  wire[7:0]  threshold, // activation threshold
    output wire       result     // actual result of perceptron calculation
);
    reg[7:0] weights; // how to get float weights
    reg[7:0] net_input;
    wire error;

    always @(posedge clk) begin
        if (!reset) begin
            result <= 0;
            net_input <= 0;
            // SGD
            weights <= 8'b01100101; //temp
        end else begin
            result <= (net_input >= threshold); // evaluate perceptron
            // error calculation
        end
    end

    integer i;

    for (i = 0; i < 8; i = i + 1) // based on 8 inputs
    begin
        // integer w = 8 * i;
        net_input[7:0] <= net_input[7:0] + in[i] * weights[i]; // multiply inputs with corresponding weights
    end

endmodule
