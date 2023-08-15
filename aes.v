`timescale 1ns / 1ps
module aes(
    input [127:0]Mes,
    input [127:0]Key,
    input clk,reset,
    output wire  [127:0]Mes_xor_Key,
    output [127:0] Final_EncRypted
    );
    wire[7:0]Message[0:3][0:3];
    wire[7:0]Mes_Key[0:3][0:3];
    genvar i,k;
    generate 
        for(i=0;i<4;i=i+1)
        begin
            for(k=0;k<4;k=k+1)
            begin
                assign Message[k][i]=Mes[16*8-1-8*k-32*i:16*8-1-8*k-32*i-7];
                assign Mes_Key[k][i]=Key[16*8-1-8*k-32*i:16*8-1-8*k-32*i-7];
            end
        end
    endgenerate
    assign Mes_xor_Key=Key^Mes;
    
    wire [127:0]subsbytes[10:0];
    wire [127:0]shiftrows[10:0];    
    wire [127:0]mixcolumns[10:0];
    wire [127:0]roundkeys[10:0];
    wire [127:0]mes_32[10:0];
    assign roundkeys[0]=Key;
    assign mes_32[0]=Mes;
    assign mixcolumns[0]= Mes;
    assign subsbytes[0]='b0;
    assign shiftrows[0]='b0;
    calc_Round_Key inst_round_1(clk,reset,1'b1,4'h1,roundkeys[0],roundkeys[1]);
    
    assign mes_32[1]=mixcolumns[0] ^ roundkeys[0];
    Subsbytes inst_Sub_1(mes_32[1],clk,reset,subsbytes[1]);
    shift_Rows inst_shift_1(subsbytes[1],clk,reset,shiftrows[1]);
    multiply_matrices inst_mul_1(shiftrows[1],mixcolumns[1]);
    calc_Round_Key inst_round_2(clk,reset,1'b1,4'h2,roundkeys[1],roundkeys[2]);
    
    assign mes_32[2]=mixcolumns[1] ^ roundkeys[1];
    Subsbytes inst_Sub_2(mes_32[2],clk,reset,subsbytes[2]);
    shift_Rows inst_shift_2(subsbytes[2],clk,reset,shiftrows[2]);
    multiply_matrices inst_mul_2(shiftrows[2],mixcolumns[2]);
    calc_Round_Key inst_round_3(clk,reset,1'b1,4'h3,roundkeys[2],roundkeys[3]);
    
    assign mes_32[3]=mixcolumns[2] ^ roundkeys[2];
    Subsbytes inst_Sub_3(mes_32[3],clk,reset,subsbytes[3]);
    shift_Rows inst_shift_3(subsbytes[3],clk,reset,shiftrows[3]);
    multiply_matrices inst_mul_3(shiftrows[3],mixcolumns[3]);
    calc_Round_Key inst_round_4(clk,reset,1'b1,4'h4,roundkeys[3],roundkeys[4]);
    
    assign mes_32[4]=mixcolumns[3] ^ roundkeys[3];
    Subsbytes inst_Sub_4(mes_32[4],clk,reset,subsbytes[4]);
    shift_Rows inst_shift_4(subsbytes[4],clk,reset,shiftrows[4]);
    multiply_matrices inst_mul_4(shiftrows[4],mixcolumns[4]);
    calc_Round_Key inst_round_5(clk,reset,1'b1,4'h5,roundkeys[4],roundkeys[5]);
    
    assign mes_32[5]=mixcolumns[4] ^ roundkeys[4];
    Subsbytes inst_Sub_5(mes_32[5],clk,reset,subsbytes[5]);
    shift_Rows inst_shift_5(subsbytes[5],clk,reset,shiftrows[5]);
    multiply_matrices inst_mul_5(shiftrows[5],mixcolumns[5]);
    calc_Round_Key inst_round_6(clk,reset,1'b1,4'h6,roundkeys[5],roundkeys[6]);
    
    assign mes_32[6]=mixcolumns[5] ^ roundkeys[5];
    Subsbytes inst_Sub_6(mes_32[6],clk,reset,subsbytes[6]);
    shift_Rows inst_shift_6(subsbytes[6],clk,reset,shiftrows[6]);
    multiply_matrices inst_mul_6(shiftrows[6],mixcolumns[6]);
    calc_Round_Key inst_round_7(clk,reset,1'b1,4'h7,roundkeys[6],roundkeys[7]);
    
    assign mes_32[7]=mixcolumns[6] ^ roundkeys[6];
    Subsbytes inst_Sub_7(mes_32[7],clk,reset,subsbytes[7]);
    shift_Rows inst_shift_7(subsbytes[7],clk,reset,shiftrows[7]);
    multiply_matrices inst_mul_7(shiftrows[7],mixcolumns[7]);
    calc_Round_Key inst_round_8(clk,reset,1'b1,4'h8,roundkeys[7],roundkeys[8]);
    
    assign mes_32[8]=mixcolumns[7] ^ roundkeys[7];
    Subsbytes inst_Sub_8(mes_32[8],clk,reset,subsbytes[8]);
    shift_Rows inst_shift_8(subsbytes[8],clk,reset,shiftrows[8]);
    multiply_matrices inst_mul_8(shiftrows[8],mixcolumns[8]);
    calc_Round_Key inst_round_9(clk,reset,1'b1,4'h9,roundkeys[8],roundkeys[9]);
    
    assign mes_32[9]=mixcolumns[8] ^ roundkeys[8];
    Subsbytes inst_Sub_9(mes_32[9],clk,reset,subsbytes[9]);
    shift_Rows inst_shift_9(subsbytes[9],clk,reset,shiftrows[9]);
    multiply_matrices inst_mul_9(shiftrows[9],mixcolumns[9]);
    calc_Round_Key inst_round_10(clk,reset,1'b1,4'ha,roundkeys[9],roundkeys[10]);

    assign mes_32[10]=mixcolumns[9] ^ roundkeys[9];
    Subsbytes inst_Sub_10(mes_32[10],clk,reset,subsbytes[10]);
    shift_Rows inst_shift_10(subsbytes[10],clk,reset,shiftrows[10]);
    multiply_matrices inst_mul_10(shiftrows[10],mixcolumns[10]);
    
    assign Final_EncRypted = roundkeys[10] ^ shiftrows[10];
    
endmodule