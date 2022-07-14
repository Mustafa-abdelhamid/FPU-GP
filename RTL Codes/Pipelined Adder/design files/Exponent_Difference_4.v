module Exponent_Difference_4 (d , carry , zero_d , sgn_d);
input [7:0]d;
input carry;
output reg zero_d , sgn_d;
always@(*)
begin
    if (d==0)
    begin
      zero_d=1;
    end
	else 
	begin
	    zero_d=0;
	end
sgn_d=  carry ; 
end

endmodule