module bit_2_reg (in , clk , rst , out);
input [1:0]in;
input clk;
input rst;
output reg [1:0]out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 2'b 00;
    else
        out <= in;
end
endmodule