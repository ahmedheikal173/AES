`timescale 1ns / 1ps
module multiply_matrices(
    input [127:0] in1,
    input [127:0] out
    );
    
    wire [7:0]in1_matrix[0:3][0:3];
    wire [7:0]mix_col[0:3][0:3];
    wire [31:0]res_matrix[0:3];
    wire [31:0]const_Matrix[0:3];
    assign const_Matrix[0]=32'h02030101;
    assign const_Matrix[1]=32'h01020301;
    assign const_Matrix[2]=32'h01010203;
    assign const_Matrix[3]=32'h03010102;
     genvar i,k;
       generate 
           for(i=0;i<4;i=i+1)
           begin
               for(k=0;k<4;k=k+1)
               begin
                  assign in1_matrix[k][i]=in1[16*8-1-8*k-32*i:16*8-1-8*k-32*i-7];
               end
           end
       endgenerate
       assign res_matrix[0]={in1_matrix[0][0],in1_matrix[1][0],in1_matrix[2][0],in1_matrix[3][0]};
       assign res_matrix[1]={in1_matrix[0][1],in1_matrix[1][1],in1_matrix[2][1],in1_matrix[3][1]};
       assign res_matrix[2]={in1_matrix[0][2],in1_matrix[1][2],in1_matrix[2][2],in1_matrix[3][2]};
       assign res_matrix[3]={in1_matrix[0][3],in1_matrix[1][3],in1_matrix[2][3],in1_matrix[3][3]};
       
       
    generate 
        for(i=0;i<4;i=i+1)
        begin
            for(k=0;k<4;k=k+1)
            begin
                multibly_col_by_row inst(res_matrix[i],const_Matrix[k],mix_col[k][i]);
            end
        end
    endgenerate
    
    generate
        for(i=0;i<4;i=i+1)
           begin
               for(k=0;k<4;k=k+1)
               begin
                  assign out[16*8-1-8*k-32*i:16*8-1-8*k-32*i-7]=mix_col[k][i];
               end
           end
       endgenerate
endmodule
