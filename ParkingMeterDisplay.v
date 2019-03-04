`timescale 1ns / 1ps

module ParkingMeterDisplay(
    input clk,
    input second,
    input below200,
    input [27:0] sev_seg_data,
    output reg [3:0] an,
    output reg [6:0] sseg
    );
    
    reg alternate = 0;

    reg [1:0] state;
    reg [1:0] next_state;
    
    always @ (*) begin
        case (state)
            2'b00: begin
                sseg = sev_seg_data[27:21];
                next_state = 2'b01;
            end
            2'b01: begin
                sseg = sev_seg_data[20:14];
                next_state = 2'b10;
            end
            2'b10: begin
                sseg = sev_seg_data[13:7];
                next_state = 2'b11;
            end
            2'b11: begin
                sseg = sev_seg_data[6:0];
                next_state = 2'b00;
            end
        endcase
    end

    always @(posedge second) begin
        if(below200 && alternate)
            an = 4'b1111;
        else begin
            case (state)
                2'b00: an = 4'b0111;
                2'b01: an = 4'b1011;
                2'b10: an = 4'b1101;
                2'b11: an = 4'b1110;
            endcase
        end
        alternate = ~alternate;
    end

    always @(posedge clk) begin
        state <= next_state;
    end
    
endmodule