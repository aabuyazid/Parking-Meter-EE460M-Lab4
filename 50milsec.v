`timescale 1ns / 1ps

module milsec50(clk, clkSlow);
    input clk;
    output reg clkSlow;
    
    reg [24:0] count;
    
    always@( posedge clk) begin
        if(count == 5000000)
            clkSlow <= ~clkSlow;
        else
            count = count + 1;
    end
    
endmodule