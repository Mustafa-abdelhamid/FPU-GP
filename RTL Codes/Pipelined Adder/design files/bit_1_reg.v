    module bit_1_reg (in , clk , rst , out);
input in;
input clk;
input rst;
output reg out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 1'b 0;
    else
        out <= in;
end
endmodule
    
