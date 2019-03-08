`timescale 1ns / 1ps

module HalfSecond(
    input clk,
    output reg half_second
);

reg [25:0] second_divider = 0;

always @(posedge clk) 
begin
    if(second_divider == 25000000) begin 
        half_second <= ~half_second;
        second_divider <= 0;
    end
    else
    second_divider <= second_divider + 1;
end
endmodule
