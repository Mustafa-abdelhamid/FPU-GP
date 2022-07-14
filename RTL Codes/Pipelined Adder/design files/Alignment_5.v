module Alignment_5 (Mx , My , Cmp);
input [22:0]Mx , My;
output reg Cmp;
always@(*)
begin
    if(Mx>=My)				//Compare Block
			begin
				Cmp = 1'b0;		
			end
		else
			begin
				Cmp = 1'b1;
			end
end
endmodule