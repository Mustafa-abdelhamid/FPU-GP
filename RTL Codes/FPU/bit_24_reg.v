    module bit_24_reg (in , clk , rst , out);
input [23:0]in;
input clk;
input rst;
output reg [23:0]out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 24'b 0000_0000_0000_0000_0000_0000;
    else
        out <= in;
end
endmodule
    
