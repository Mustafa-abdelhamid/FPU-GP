module round_5 (hidden , internal_mantessa , MOut);
input hidden;
input [22:0]internal_mantessa;
output reg [23:0]MOut;
always@(*)
begin
    MOut = {hidden , internal_mantessa};
end
endmodule