module Alignment_2 (bef_shift_x , bef_shift_y , sgn_d , out_x , out_y);
input [23:0]bef_shift_x , bef_shift_y;
input sgn_d;
output reg [23:0]out_x , out_y;
always@(*)
begin
    if(sgn_d)						//SWAP bloc;
			begin		
				out_x = bef_shift_y;					
				out_y = bef_shift_x;
			end 
		else 
			begin
				out_x = bef_shift_x;
				out_y = bef_shift_y;
			end
end
endmodule