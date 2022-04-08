`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2022 12:24:47 AM
// Design Name: 
// Module Name: bcdtoseg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bcdto7segment2d_dataflow(
    input [3:0] x,
    output [6:0] seg
    );
    
    reg [6:0] seg;
    
    always @ (x)
    begin
        
        case(x)
            4'b0000: seg = 7'b1000000;
            4'b0001: seg = 7'b1111001;
            4'b0010: seg = 7'b0100100;
            4'b0011: seg = 7'b0110000;
            4'b0100: seg = 7'b0011001;
            4'b0101: seg = 7'b0010010;
            4'b0110: seg = 7'b0000010;
            4'b0111: seg = 7'b1111000;
            4'b1000: seg = 7'b0000000;
            4'b1001: seg = 7'b0010000;
            4'b1010: seg = 7'b0000110;
            4'b1011: seg = 7'b0101011;
            4'b1100: seg = 7'b1000000;
            4'b1101: seg = 7'b0100001;
            default: seg = 7'b1000000;
        endcase
    end
endmodule
