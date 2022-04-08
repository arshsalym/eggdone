`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2022 02:52:31 PM
// Design Name: 
// Module Name: eggtimer_tb
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


module eggtimer_tb();
    reg enable;
    reg reset;
    reg clk;
    reg cooktime;
    reg start;
    reg InMin;
    reg InSec;
    wire [3:0] sec;
    wire [3:0] tensec;
    wire [3:0] min;
    wire [3:0] tenmin;
    wire ENABLE;
    wire TIMERSTATUS;
    
    Master_Controller_NOSSD DUT (.enable(enable), .reset(reset), .clk(clk), .cooktime(cooktime), .start(start), .InMin(InMin), .InSec(InSec), .sec(sec), .tensec(tensec), .min(min), .tenmin(tenmin), .ENABLE(ENABLE), .TIMERSTATUS(TIMERSTATUS));
          initial
           begin
               clk=0;
               reset=1;
               cooktime = 0;
               start = 0;
               InMin = 0;
               InSec = 0;
               enable = 0;
               #20 reset=0;
               #10 cooktime=1;
               #1 InMin=1;
               #2 InMin=0;
               #1 InMin=1;
               #2 InMin=0;
               #1 InMin=1;
               #2 InMin=0;
               #2 InSec=0;
               #1 InSec=1;
               #2 InSec=0;
               #1 InSec=1;
               #2 InSec=0;
               #2 cooktime=0;
               #2 enable=1;
               #4 start=1;
               #4 start=0;                                                          
               #400 
               #10 cooktime=1;
               #2 cooktime=0;
               #2 enable=1;
               #4 start=1;
               #4 start=0;
               #30 reset=1;               
           end
           always #1 clk=~clk;
   
   endmodule
