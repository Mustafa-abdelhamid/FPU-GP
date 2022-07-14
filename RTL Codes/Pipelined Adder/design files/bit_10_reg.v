    module bit_10_reg (in , clk , rst , out);
input [9:0]in;
input clk;
input rst;
output reg [9:0]out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 10'b 0000_0000_00;
    else
        out <= in;
end
endmodule