    module bit_3_reg (in , clk , rst , out);
input [2:0]in;
input clk;
input rst;
output reg [2:0]out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 3'b 000;
    else
        out <= in;
end
endmodule
    
