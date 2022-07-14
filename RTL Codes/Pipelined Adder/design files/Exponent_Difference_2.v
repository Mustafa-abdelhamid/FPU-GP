module Exponent_Difference_2 (zero_Ex , zero_Ey , Ex , Ey , carry , difference);
input zero_Ex , zero_Ey;
input [7:0]Ex,Ey;
output reg carry;
output reg [7:0]difference;
always@(*)
begin
    if((zero_Ey && (~zero_Ex)))
		begin
			{carry,difference}= Ex + ~Ey ; 
		end
	else if((zero_Ex && (~zero_Ey)))
		begin
			{carry,difference}= Ex + ~Ey + 1'b1 + 1'b1 ;
		end
	else
		begin
			{carry,difference}= Ex + ~Ey + 1'b1 ;
		end
end
endmodule