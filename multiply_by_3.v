`timescale 1ns / 1ps
module multiply_by_3(
        input [7:0] in3,
        output  [7:0] out3
    );
    wire [7:0] out3_stage;
    
    multiply_by_2 inst(in3,out3_stage);
    assign out3 = in3 ^ out3_stage;
endmodule
