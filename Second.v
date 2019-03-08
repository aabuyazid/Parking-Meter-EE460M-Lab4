`timescale 1ns / 1ps

module Second(
    input clk,
    output reg second
);

reg [26:0] second_divider = 0;

always @(posedge clk) 
begin
    if(second_divider == 50000000) begin 
        second <= ~second;
        second_divider <= 0;
    end
    else
    second_divider <= second_divider + 1;
end
endmodule
