`timescale 1ns / 1ps

module Incrementer(clk, u, l, r, d, sw0, sw1, timeIn, timeOut);
    input clk;
    input u;
    input l;
    input r;
    input d;
    input sw0;
    input sw1;
    input [15:0] timeIn;
    output [15:0] timeOut;
    wire U, L, R, D, SW0, SW1;
    reg [15:0] timeCurrent = 0;
    
    Debounce b0 (clk, u, U);
    Debounce b1 (clk, l, L);
    Debounce b2 (clk, r, R);
    Debounce b3 (clk, d, D);
    Debounce b4 (clk, sw0, SW0);
    Debounce b5 (clk, sw1, SW1);
    
    assign timeOut = (timeCurrent < 9999)? timeCurrent : 9999; 
    always@(posedge clk) begin
        case({U,L,R,D,SW0,SW1})
            6'b100000 : timeCurrent <= timeCurrent + 10;
            6'b010000 : timeCurrent <= timeCurrent + 180;
            6'b001000 : timeCurrent <= timeCurrent + 200;
            6'b000100 : timeCurrent <= timeCurrent + 550;
            6'b000010 : timeCurrent <= 10;
            6'b000001 : timeCurrent <= 205;
            default   : timeCurrent <= timeIn;
        endcase
        end
endmodule
