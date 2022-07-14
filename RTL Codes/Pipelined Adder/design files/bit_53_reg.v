    module bit_53_reg (in , clk , rst , out);
input [52:0]in;
input clk;
input rst;
output reg [52:0]out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 53'b 0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0;
    else
        out <= in;
end
endmodule
    
