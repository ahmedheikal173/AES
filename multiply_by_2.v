`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/02/2023 10:15:04 AM
// Design Name: 
// Module Name: multiply_by_2
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


module multiply_by_2(
    input [7:0] in2,
    output reg [7:0] out2
    );
    always @(*)
    begin
        if(in2[7]==0)
            out2=(in2<<1) ^ 8'b00011011;
        else 
            out2=(in2<<1);
    end
endmodule
