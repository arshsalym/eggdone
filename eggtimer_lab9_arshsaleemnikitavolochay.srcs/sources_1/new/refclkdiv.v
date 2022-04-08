module refclkdivider(
    input clock_in,enable,
    output reg clock_out
    );
    reg[27:0] counter=28'd0;
    parameter DIVISOR = 28'd5000;
    always @(posedge clock_in)
    begin
        if(enable)
        begin
            counter <= counter + 1;
            if(counter == DIVISOR) 
            begin
                counter <= 0;
                clock_out <= ~clock_out;
            end
        end
    end
endmodule

