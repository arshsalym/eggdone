`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2022 10:53:47 PM
// Design Name: 
// Module Name: Master_Controller
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


module Master_Controller(
    input enable,
    input reset,
    input clk,
    input cooktime,
    input start,
    input InMin,
    input InSec,
    output [6:0] seg,
    output reg [7:0] AN,
    output [7:0] progLED,
    output ENABLE,
    output TIMERSTATUS
    );
    
    //Output wires for countdown
    
    wire[3:0] cout_sec;
    wire[3:0] cout_tensec;
    wire[3:0] cout_min;
    wire[3:0] cout_tenmin;
    wire done;
    //Output wires for cooktime
    
    wire[3:0] cook_sec;
    wire[3:0] cook_tensec;
    wire[3:0] cook_min;
    wire[3:0] cook_tenmin;
    
    reg [3:0] sec;
    reg [3:0] tensec;
    reg [3:0] min;
    reg [3:0] tenmin;
    reg [1:0] refresh = 2'b00;
    reg [3:0] x;
    
    clk_wiz_0 CLK_WZRD (.clk_in1(clk), .clk_out1(wclk), .locked(locked)); // Clock wizard generates 5MHz clock signal
    
    ClocktoSecond clkSec(.clk(wclk), .clkOut(clkOut)); // Converts clock wizard signal to seconds clock signal
    Count_Time countdown(.clk(clkOut), .enable(enable), .reset(reset), .start(start), .load_sec(cook_sec), .load_tensec(cook_tensec), .load_min(cook_min), .load_tenmin(cook_tenmin), .cout_sec(cout_sec), .cout_tensec(cout_tensec), .cout_min(cout_min), .cout_tenmin(cout_tenmin), .done(done), .timerstatus(TIMERSTATUS));
    ProgressBar progress(.clk(clkOut), .enable(enable), .reset(reset), .start(start), .time_sec(cook_sec), .time_tensec(cook_tensec), .time_min(cook_min), .time_tenmin(cook_tenmin), .progLED(progLED));
    clkfordebounce debclk(.clock_in(wclk), .clock_out(dbclk), .enable(1));
    Cook_Time cookOuttime(.clk(dbclk), .InMin(InMin), .InSec(InSec), .cooktime(cooktime), .cook_sec(cook_sec), .cook_tensec(cook_tensec), .cook_min(cook_min), .cook_tenmin(cook_tenmin));
    refclkdivider refclkdiv(.clock_in(wclk), .clock_out(refreshClk), .enable(1));
    bcdto7segment2d_dataflow ouput(.x(x), .seg(seg));

    assign ENABLE = enable;
    
    always @(posedge wclk)
        begin
        
        if(cooktime)
            begin
            sec <= cook_sec;
            tensec <= cook_tensec;
            min <= cook_min;
            tenmin <= cook_tenmin;
            end
            
        else if (~(cooktime))
            begin
            if (~(reset)) 
                begin
                sec <= cout_sec;
                tensec <= cout_tensec;
                min <= cout_min;
                tenmin <= cout_tenmin;
                end
            else
                begin
                sec <= 0;
                tensec <= 0;
                min <= 0;
                tenmin <= 0;
                end
        end
        end     

        
        always @(posedge refreshClk)
        case (done)
        0:
        begin
        if(refresh == 2'b00)
            begin
            AN <= 8'b11111110;
            x <= sec;
            refresh <= 2'b01;
            end
        if(refresh == 2'b01)
            begin
            AN <= 8'b11111101;
            x <= tensec;
            refresh <= 2'b10;
            end
        if(refresh == 2'b10)
            begin
            AN <= 8'b11111011;
            x <= min;
            refresh <= 2'b11;
            end
        if(refresh == 2'b11)
            begin
            AN <= 8'b11110111;
            x <= tenmin;
            refresh <= 2'b00;
            end
        end
        1:
        begin
        if(refresh == 2'b00)
            begin
            AN <= 8'b11110111;
            x <= 4'b1101;
            //7'b0100001
            refresh <= 2'b01;
            end
        if(refresh == 2'b01)
            begin
            AN <= 8'b11111011;
            x <= 4'b1100;
            // 7'b1000000
            refresh <= 2'b10;
            end
        if(refresh == 2'b10)
            begin
            AN <= 8'b11111101;
            x <= 4'b1011;
            //7'b0101011
            refresh <= 2'b11;
            end
        if(refresh == 2'b11)
            begin
            AN <= 8'b11111110;
            x <= 4'b1010;
            //7'b0000110
            refresh <= 2'b00;
            end
        end
        endcase
        
    
endmodule
