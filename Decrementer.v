`timescale 1ns / 1ps

module Decrementer(
    input half_second,
    input [15:0] adder_value,
    output [15:0] decrement_value,
    output below200
);

reg decrement = 0;
reg [15:0] decrement_value_reg;
assign decrement_value = decrement_value_reg;
assign below200 = (decrement_value < 200) ? 1:0;
always @(*) begin
    if(decrement) begin
        if(adder_value > 0) 
            decrement_value_reg = adder_value - 1;
        else
            decrement_value_reg = 0;
    end
    else 
        decrement_value_reg = adder_value;
end

always @(posedge half_second) begin
    decrement = ~decrement;
end
endmodule
