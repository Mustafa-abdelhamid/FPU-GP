module Alignment_1 (Ex , Ey , Mx , My , bef_shift_x , bef_shift_y);
input [7:0]Ex,Ey;
input [22:0]Mx,My;
output reg [23:0]bef_shift_x , bef_shift_y;
always@(*)
begin
    if(Ey==0)		
	begin
		bef_shift_y = {1'b0,My[22:0]};  //// kanet l7d 1
	end
else
	begin
		bef_shift_y = {1'b1,My[22:0]};
	end

if(Ex==0)		
	begin
		bef_shift_x = {1'b0,Mx[22:0]};
	end
else
	begin
		bef_shift_x = {1'b1,Mx[22:0]};
	end			
end
endmodule