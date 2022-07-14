module Exponent_Difference_3 (carry , difference , d);
input carry;
input [7:0]difference;
output reg [7:0]d;
//internal signals
reg int_sig;
always@(*)
begin
    if (carry) 
	begin
		{int_sig,d}= ~difference + 1'b1 ;
	end
	else 
		begin
		d=difference ;
		int_sig= 1'b0 ; 
		end
end
endmodule