`timescale 1ns / 1ps

module milsec50(clk, clkSlow);
    input clk;
    output clkSlow;
    
    reg [24:0] count;
    reg slow = 0;
    assign clkSlow = slow;
    
    always@( posedge clk) begin
        if(count == 5000000) begin
            slow <= ~slow;
            count <= 0;
        end
        else
            count = count + 1;
    end
    
endmodule