`default_nettype none

module perceptron (
    input  wire       clk,       // clock
    input  wire       reset,     // reset_n - low to reset
    input  wire[6:0]  in,        // perceptron inputs
    input  wire[7:0]  threshold, // activation threshold
    input  wire       exp_res,   // expected result 
    output wire[1:0]  result     // actual result of perceptron calculation
);
    reg[7:0] weights [0:6]; // 7 8-bit weights
    reg[7:0] net_input;
    reg[7:0] loss;
    reg[2:0] res_tmp;
    integer i;

    always @(posedge clk) begin
        if (!reset) begin
            res_tmp <= 0;
            net_input <= 0;
            loss <= 8'b0;
            for (i = 0; i < 7; i = i + 1) begin
                weights[i] <= 8'b0;
            end
        end else begin
            // evaluate perceptron
            reg[7:0] net_input_tmp;
            for (i = 0; i < 7; i = i + 1) begin
                net_input_tmp = net_input_tmp + in[i] * weights[i]; // multiply inputs with corresponding weights
            end

            net_input <= net_input_tmp;
            
            if (net_input < threshold) begin
                res_tmp <= 2'b11; // -1
            end else begin
                res_tmp <= 2'b01; // +1
            end

            // loss calculation == max(0, -exp_res*result)
            if (result * 2'b11 * exp_res > 0) begin
                loss <= result * 2'b11 * (exp_res);
            end

            // update weights
            for (i = 0; i < 8; i = i + 1) begin
                weights[i] = weights[i] + loss * in[i];
            end
        end
    end

    assign result = res_tmp;

endmodule
