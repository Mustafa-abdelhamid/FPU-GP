module Exponent_Difference_1 (Ex , Ey , zero_Ex , zero_Ey);
input [7:0]Ex,Ey;
output reg zero_Ex , zero_Ey;
always@(*)
begin
    zero_Ex = ~| Ex;
	zero_Ey = ~| Ey;
end
endmodule