`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2022 04:07:39 PM
// Design Name: 
// Module Name: ProgressBar
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


module ProgressBar(
    input clk,
    input enable,
    input reset,
    input start,
    input [3:0] time_sec,
    input [3:0] time_tensec,
    input [3:0] time_min,
    input [3:0] time_tenmin,
    output reg [7:0] progLED
    );
    
    reg [11:0] totalseconds;
    reg [8:0] cSeconds;
    reg [8:0] eightDiv;
    reg [3:0] statLED;   
      
    parameter COUNT_SIZE = 12;
    
    initial totalseconds = 12'b0;
    initial cSeconds = 9'b0;
    initial eightDiv = 9'b0;
    initial progLED = 8'b0;
    initial statLED = 4'b0;

    always @(posedge clk)
        begin
            if (~(reset))
            begin
                if(enable & ~start)   
                begin
                    if(~(statLED == 4'b0))
                        begin                        
                            if(cSeconds == eightDiv)
                                begin
                                cSeconds <= 1;
                                statLED <= statLED -1;
                                end
                            else if(~(cSeconds == eightDiv))
                                begin
                                cSeconds <= cSeconds +1;
                                
                                end      
                        end                      
                        
                case (statLED)
                    4'b1000: progLED = 8'b11111111;
                    4'b0111: progLED = 8'b01111111;
                    4'b0110: progLED = 8'b00111111;
                    4'b0101: progLED = 8'b00011111;
                    4'b0100: progLED = 8'b00001111;
                    4'b0011: progLED = 8'b00000111;
                    4'b0010: progLED = 8'b00000011;
                    4'b0001: progLED = 8'b00000001;
                    4'b0000: progLED = 8'b00000000;
                endcase    
                end
                     
                else if(enable & start)
                    begin
                        case (time_sec)
                                4'b0001: totalseconds = totalseconds + 1;
                                4'b0010: totalseconds = totalseconds + 2;
                                4'b0011: totalseconds = totalseconds + 3;
                                4'b0100: totalseconds = totalseconds + 4;
                                4'b0101: totalseconds = totalseconds + 5;
                                4'b0110: totalseconds = totalseconds + 6;
                                4'b0111: totalseconds = totalseconds + 7;
                                4'b1000: totalseconds = totalseconds + 8;
                                4'b1001: totalseconds = totalseconds + 9;
                        endcase
                        
                        case (time_tensec)
                                4'b0001: totalseconds = totalseconds + 10;
                                4'b0010: totalseconds = totalseconds + 20;
                                4'b0011: totalseconds = totalseconds + 30;
                                4'b0100: totalseconds = totalseconds + 40;
                                4'b0101: totalseconds = totalseconds + 50;
                        endcase
                                
                        case (time_min)
                                4'b0001: totalseconds = totalseconds + 60;
                                4'b0010: totalseconds = totalseconds + 120;
                                4'b0011: totalseconds = totalseconds + 180;
                                4'b0100: totalseconds = totalseconds + 240;
                                4'b0101: totalseconds = totalseconds + 300;
                                4'b0110: totalseconds = totalseconds + 360;
                                4'b0111: totalseconds = totalseconds + 420;
                                4'b1000: totalseconds = totalseconds + 480;
                                4'b1001: totalseconds = totalseconds + 540;
                                
                        endcase
                        case (time_tenmin)
                                4'b0001: totalseconds = totalseconds + 600;
                                4'b0010: totalseconds = totalseconds + 1200;
                                4'b0011: totalseconds = totalseconds + 1800;
                                4'b0100: totalseconds = totalseconds + 2400;
                                4'b0101: totalseconds = totalseconds + 3000;
                        endcase                        
                        
                        eightDiv[8] <= totalseconds[11];
                        eightDiv[7] <= totalseconds[10];
                        eightDiv[6] <= totalseconds[9];
                        eightDiv[5] <= totalseconds[8];
                        eightDiv[4] <= totalseconds[7];
                        eightDiv[3] <= totalseconds[6];
                        eightDiv[2] <= totalseconds[5];
                        eightDiv[1] <= totalseconds[4];
                        eightDiv[0] <= totalseconds[3];
                        
                        statLED = 4'b1000;
                        cSeconds = 2;
                        
                    end
                else
                    begin
                    cSeconds <= cSeconds;
                    statLED <= statLED;
                    end                    
                end              
            else if (reset)
                begin
                    totalseconds <= 0;
                    eightDiv <=0;
                    totalseconds = 12'b0;
                    cSeconds = 9'b0;
                    eightDiv = 9'b0;
                    progLED = 8'b0;
                    statLED = 4'b0;
                end
        end  
endmodule
