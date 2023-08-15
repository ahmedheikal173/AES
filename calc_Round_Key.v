`timescale 1ns / 1ps
module calc_Round_Key(
    input clk,               //system clock
    input reset,             //asynch active low reset
    input valid_in,          //valid input signal
    input [3:0]round_num,
    input [127:0] prev_key,
    output [127:0] curr_key
    );
    wire [7:0]prev_key_matrix[0:3][0:3];
    
    wire [31:0]Stages[0:3];
    wire [31:0]shiftedrow;
    wire [31:0]subword;
    wire [31:0]Rconst;
    wire [31:0]Rconst_xor_sub;
    
    wire [31:0]FinalStages[0:3];
    
    
    genvar i,k;
    generate 
            for(i=0;i<4;i=i+1)
            begin
                for(k=0;k<4;k=k+1)
                begin
                    assign prev_key_matrix[k][i]=prev_key[16*8-1-8*k-32*i:16*8-1-8*k-32*i-7];
                end
            end
     endgenerate
     assign Stages[0]={prev_key_matrix[0][0],prev_key_matrix[1][0],prev_key_matrix[2][0],prev_key_matrix[3][0]};
     assign Stages[1]={prev_key_matrix[0][1],prev_key_matrix[1][1],prev_key_matrix[2][1],prev_key_matrix[3][1]};
     assign Stages[2]={prev_key_matrix[0][2],prev_key_matrix[1][2],prev_key_matrix[2][2],prev_key_matrix[3][2]};
     assign Stages[3]={prev_key_matrix[0][3],prev_key_matrix[1][3],prev_key_matrix[2][3],prev_key_matrix[3][3]};
     
     
     assign shiftedrow={prev_key_matrix[1][3],prev_key_matrix[2][3],prev_key_matrix[3][3],prev_key_matrix[0][3]};
     generate 
             for(i=0;i<4;i=i+1)
             begin
                SBox inst(
                    .reset(reset),
                    .clk(clk),
                    .valid_in(valid_in),
                    .addr(shiftedrow[31-i*8:31-i*8-7]),
                    .dout(subword[31-i*8:31-i*8-7])
                );
             end
     endgenerate
     R_Const RJ(
            .round(round_num),
            .clk(clk),
            .consty(Rconst)
     );
     assign Rconst_xor_sub =  Rconst ^ subword;     
     
     assign FinalStages[0]= Rconst_xor_sub ^ Stages[0];
     assign FinalStages[1]= FinalStages[0] ^ Stages[1]; 
     assign FinalStages[2]= FinalStages[1] ^ Stages[2]; 
     assign FinalStages[3]= FinalStages[2] ^ Stages[3]; 
     assign curr_key = {FinalStages[0],FinalStages[1],FinalStages[2],FinalStages[3]};
     
       
        
endmodule
