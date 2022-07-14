module Alignment_4_4 (out_y_shR , sticky , out_y_with_T);
input [52:0]out_y_shR;
input sticky;
output reg [26:0]out_y_with_T;
always@(*)
begin
    out_y_with_T={out_y_shR[52:27],sticky};
end
endmodule