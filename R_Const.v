`timescale 1ns / 1ps
module R_Const(
    input [3:0] round,
    input clk,
    output reg[31:0] consty
    );
    
    always @(posedge clk)
    begin
        if(round==4'h1)
            consty<=32'h01000000;
        else if(round==4'h2)
            consty<=32'h02000000;
        else if(round==4'h3)
            consty<=32'h04000000;
        else if(round==4'h4)
            consty<=32'h08000000;
        else if(round==4'h5)
            consty<=32'h10000000;
        else if(round==4'h6)
            consty<=32'h20000000;
        else if(round==4'h7)
            consty<=32'h40000000;
        else if(round==4'h8)
            consty<=32'h80000000;
        else if(round==4'h9)
            consty<=32'h1b000000;
        else if(round==4'ha)
            consty<=32'h36000000;
    end
endmodule
