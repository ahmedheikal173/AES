`timescale 1ns / 1ps
module Subsbytes(
    input [127:0]Mes,
    input clk,reset,
    output wire [127:0]aesBox_result
    );
    
    wire[7:0]Message[0:3][0:3];
    wire [7:0]aes_result[0:3][0:3];
    genvar i,k;
        generate 
            for(i=0;i<4;i=i+1)
            begin
                for(k=0;k<4;k=k+1)
                begin
                    assign Message[k][i]=Mes[16*8-1-8*k-32*i:16*8-1-8*k-32*i-7];
                    SBox AESBox(
                                            .clk(clk),
                                            .reset(reset),
                                            .valid_in(1'b1),
                                            .addr(Message[k][i]),
                                            .dout(aes_result[k][i])
                                );
                    assign aesBox_result[16*8-1-8*k-32*i:16*8-1-8*k-32*i-7]=aes_result[k][i];
                end
            end
        endgenerate        
endmodule
