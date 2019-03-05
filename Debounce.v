`timescale 1ns / 1ps

module Debounce(clk, in, out);
    input clk;
    input in;
    output out;

    reg cleaner, clean, pulse;
    wire clkSlow;
    milsec50(clk, clkSlow);
    assign out = pulse & clean;
    always@(posedge clkSlow) begin
       pulse <= clean;
   end
   always@(posedge clk) begin
       cleaner <= in;
       clean <= cleaner;
   end
   
endmodule
