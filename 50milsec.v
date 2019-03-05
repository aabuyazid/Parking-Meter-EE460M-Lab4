`timescale 1ns / 1ps

module milsec50(clk, clkSlow);
    input clk;
    output clkSlow;
    
    reg [21:0] count;
    
    assign clkSlow = count[21];
    always@( posedge clk) begin
       count = count + 1;
    end
endmodule