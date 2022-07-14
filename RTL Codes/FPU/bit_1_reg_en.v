    module bit_1_reg_en (in , clk , rst , enable , out);
input in;
input clk;
input rst;
input enable;
output reg out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 1'b 0;
    else if(enable)
        out <= in;
end
endmodule
    
