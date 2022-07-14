    module bit_27_reg (in , clk , rst , out);
input [26:0]in;
input clk;
input rst;
output reg [26:0]out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 27'b 0000_0000_0000_0000_0000_0000_000;
    else
        out <= in;
end
endmodule
    
