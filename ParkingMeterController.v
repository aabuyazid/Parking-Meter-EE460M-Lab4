`timescale 1ns / 1ps
`define SECOND 50000000

module ParkingMeterController(
    input clk,
    input u,
    input l,
    input r,
    input d,
    input sw0,
    input sw1,
    output [15:0] curr_time,
    output below200,
    output isZero
);

wire U, L, R, D, SW0, SW1;
reg [15:0] curr_time_reg = 0;
reg below200_reg = 1;
reg isZero_reg = 1;

reg [26:0] decrement = 0;

assign curr_time = curr_time_reg;
assign below200 = below200_reg;
assign isZero = isZero_reg;

Debounce b0 (clk, u, U);
Debounce b1 (clk, l, L);
Debounce b2 (clk, r, R);
Debounce b3 (clk, d, D);
Debounce b4 (clk, sw0, SW0);
Debounce b5 (clk, sw1, SW1);

always @(posedge clk) begin
    if(decrement == `SECOND) begin
        if(curr_time_reg == 0)
            curr_time_reg <= 0;
        else
            curr_time_reg <= curr_time_reg - 1;

        decrement <= 0;
    end
    else
        decrement <= decrement + 1;

    if(U)
        curr_time_reg <= curr_time_reg + 10;
    else if(L)
        curr_time_reg <= curr_time_reg + 180;
    else if(R)
        curr_time_reg <= curr_time_reg + 200;
    else if(D)
        curr_time_reg <= curr_time_reg + 550; 
    else if(SW0)
        curr_time_reg <= 10;
    else if(SW1)
        curr_time_reg <= 205;
    else 
        curr_time_reg <= curr_time_reg;

    /*
    if(curr_time_reg > 9999)
        curr_time_reg <= 9999;
    */
    if(curr_time_reg < 200) begin
        isZero_reg <= (curr_time_reg == 0) ? 1:0;
        below200_reg <= 1;
    end
    else begin
        isZero_reg <= 0;
        below200_reg <= 0;
    end
end
endmodule

