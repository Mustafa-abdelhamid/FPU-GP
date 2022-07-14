    module bit_8_reg (in , clk , rst , out);
input [7:0]in;
input clk;
input rst;
output reg [7:0]out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 8'b 0000_0000;
    else
        out <= in;
end
endmodule
    
