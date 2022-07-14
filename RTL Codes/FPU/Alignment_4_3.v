module Alignment_4_3 (out_y_shR , sticky);
input [52:0]out_y_shR;
output reg sticky;
always@(*)
begin
    sticky = |out_y_shR[26:0];
end
endmodule