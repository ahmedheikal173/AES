`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/02/2023 11:01:49 AM
// Design Name: 
// Module Name: multibly_col_by_row
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


module multibly_col_by_row(
    input [31:0] in1,
    input [31:0] in2,
    output [7:0] res_mul
    );
    wire [7:0] in_col[0:3];
    wire [7:0] in_row[0:3];
    wire [7:0] result[0:3];
    genvar i;
    generate 
        for(i=0;i<4;i=i+1)
        begin
            assign in_col[i]=in1[32-1-8*i:32-1-8*i-7];
            assign in_row[i]=in2[32-1-8*i:32-1-8*i-7];
            multiply_by_1_2_3 inst(in_col[i],in_row[i],result[i]);
        end
    endgenerate
   assign res_mul=result[0] ^ result[1] ^ result[2] ^ result[3]; 
    
endmodule
