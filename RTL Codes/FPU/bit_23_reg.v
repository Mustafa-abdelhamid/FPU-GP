    module bit_23_reg (in , clk , rst , out);
input [22:0]in;
input clk;
input rst;
output reg [22:0]out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 23'b 0000_0000_0000_0000_0000_000;
    else
        out <= in;
end
endmodule
    
