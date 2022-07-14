module Alignment_4_2 (shR_y , d , out_y_shR);
input [52:0]shR_y;
input [7:0]d;
output reg [52:0]out_y_shR;
always@(*)
begin
    out_y_shR = shR_y>>d;
end
endmodule