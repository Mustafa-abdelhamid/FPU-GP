    module bit_23_reg_en (in , clk , rst , enable , out);
input [22:0]in;
input clk;
input rst;
input enable;
output reg [22:0]out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 23'b 0000_0000_0000_0000_0000_000;
    else if(enable)
        out <= in;
end
endmodule
    
