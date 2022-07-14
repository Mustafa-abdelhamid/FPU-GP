    module bit_8_reg_en (in , clk , rst , enable , out);
input [7:0]in;
input clk;
input rst;
input enable;
output reg [7:0]out;
always@(posedge rst or posedge clk)
begin
    if(rst)
        out <= 8'b 0000_0000;
    else if(enable)
        out <= in;
end
endmodule
    
