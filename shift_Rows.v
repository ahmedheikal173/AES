`timescale 1ns / 1ps
module shift_Rows(
    input [127:0] subsbytes,
    input clk,reset,
    output  [127:0] shift_out
    );
    wire[7:0]subsbytes_matrix[0:3][0:3];
    reg [7:0]shift_out_matrix[0:3][0:3];
    genvar i,k;
    generate 
            for(i=0;i<4;i=i+1)
            begin
                for(k=0;k<4;k=k+1)
                begin
                    assign subsbytes_matrix[k][i]=subsbytes[16*8-1-8*k-32*i:16*8-1-8*k-32*i-7];
                end
            end
    endgenerate
    integer carry;
    generate 
               for(i=0;i<4;i=i+1)
               begin
                   for(k=0;k<4;k=k+1)
                   begin
                        always @(posedge clk)
                        begin
                            if((k==1 && i==3) || (k==2 && i>1) || (k==3 && i>0))
                                shift_out_matrix[k][i]<=subsbytes[16*8-1-8*k-32*i-32*k+128:16*8-1-8*k-32*i-7-32*k+128];
                            else
                                shift_out_matrix[k][i]<=subsbytes[16*8-1-8*k-32*i-32*k:16*8-1-8*k-32*i-7-32*k];
                        end
                   end
               end
      endgenerate
    generate 
        for(i=0;i<4;i=i+1)
        begin
            for(k=0;k<4;k=k+1)
            begin
                assign  shift_out[16*8-1-8*k-32*i:16*8-1-8*k-32*i-7]=shift_out_matrix[k][i];
            end
        end
    endgenerate
endmodule
