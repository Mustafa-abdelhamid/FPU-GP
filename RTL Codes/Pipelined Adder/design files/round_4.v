module round_4 (hidden , internal_mantessa , MOut);
input hidden;
input [22:0]internal_mantessa;
output reg [23:0]MOut;
always@(*)
begin
    MOut = {1'b1 , hidden , internal_mantessa[22:1]};
end
endmodule