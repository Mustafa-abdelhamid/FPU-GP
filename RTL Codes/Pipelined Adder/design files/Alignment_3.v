module Alignment_3 (out_x , out_y , shR_y , out_x_shR);
input [23:0]out_x , out_y;
output reg [52:0]shR_y;
output reg [26:0]out_x_shR;
always@(*)
begin
    shR_y = {out_y[23:0], 29'b0 };	
    out_x_shR = {out_x[23:0], 3'b0 };  
end
endmodule