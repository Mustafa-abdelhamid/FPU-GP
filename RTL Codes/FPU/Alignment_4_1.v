module Alignment_4_1 (shR_y , out_y_with_T);
input [52:0]shR_y;
output reg [26:0]out_y_with_T;
always@(*)
begin
    out_y_with_T=shR_y[52:26];
end
endmodule