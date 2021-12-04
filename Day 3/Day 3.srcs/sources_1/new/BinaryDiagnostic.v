`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Engineer: CJC
// 
// Create Date: 03.12.2021
// Design Name: Binary Diagnostic
// Module Name: Binary_Diagnostic
// Description: Hardware to detect an increase between two sliding window sums
//////////////////////////////////////////////////////////////////////////////////


module Binary_Diagnostic(
    input clock,
    input reset,
    input bit,
    input data,
    output reg most
    );
    reg [10:0] length;
    reg [10:0] sum;
    
    always @ (posedge clock)
    begin
        if (reset)
            begin
                length <= 12'd0;
                sum <= 12'd0;
                most <=12'd0;
            end
        else
        begin
            if (data)
            begin
                sum <= sum + bit;
                length <= length + 1'b1;
            end
            if(!data && length>0)
            begin
                most = sum > (length/2);
            end
        end
    end
    

endmodule
