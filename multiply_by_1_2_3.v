`timescale 1ns / 1ps
module multiply_by_1_2_3(
    input [7:0] in,
    input [7:0] num,
    output reg [7:0] out
    );
    
    reg [7:0] out3_stage;
    always @(*)
    begin
        if(num==2'h01)
            out = in;
            
        else if(num==2'h02)
        begin
           if(in[7]==0)
                    out=(in<<1) ^ 8'b00011011;
            else 
                    out=(in<<1);
        end
        
        else
        begin
            if(in[7]==0)
                   out3_stage=(in<<1) ^ 8'b00011011;
            else 
                   out3_stage=(in<<1);
            out = out3_stage ^ in;
        end
    end
endmodule
