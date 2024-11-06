`default_nettype none

module lif (
    input  wire [7:0] current,   // input current
    input  wire       clk,       // clock
    input  wire       reset_n,   // reset
    output reg[7:0]   state,     // current neuron state
    output wire       spike      // output spike
);
    wire [7:0] next_state;
    reg [7:0] threshold;

    always @(posedge clk) begin
        if (!reset_n) begin
            state <= 0;
            threshold <= 200;
        end else begin
            state <= next_state;
        end
    end

    // next state logic
    assign next_state = current + (spike ? 0 : (state >> 1));

    // spiking logic
    assign spike = (state >= threshold);

endmodule
