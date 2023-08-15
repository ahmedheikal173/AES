module Q1_tb();
reg click,clk,rst;
wire reg y;
wire reg[9:0]count;

Q1 P1(click,clk,rst,y,count);
integer i;
initial 
begin
    clk=0;
    forever begin
        #1 clk=~clk;
    end
end

initial
    begin
        rst = 1'b1;
        click = 1'b0;
        #50;
        rst = 1'b0;
        click = 1'b1;
        #100
        for(i=0;i<1000;i=i+1)
            begin
                @(posedge clk);
                    click = $random;
                #10;
            end
    end
endmodule