    module bit_5_reg (in , clk , rst , out);
input [4:0]in;
input clk;
input rst;
output reg [4:0]out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 5'b 00000;
    else
        out <= in;
end
endmodule
    
