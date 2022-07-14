module bit_56_reg (in , clk , rst , out);
input [55:0]in;
input clk;
input rst;
output reg [55:0]out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 56'b 0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
    else
        out <= in;
end
endmodule