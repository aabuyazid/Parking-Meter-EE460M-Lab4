`timescale 1ns / 1ps

module Decrementer(
    input second,
    input [15:0] adder_value,
    output [15:0] decrement_value;
)

reg [15:0] decrement_value_reg = 0;
assign decrement_value = decrement_value_reg;

always @(posedge second) begin
    if(adder_value > 0) 
        decrement_value_reg = adder_value - 1;
    else
        decrement_value_reg = 0;
end
endmodule
