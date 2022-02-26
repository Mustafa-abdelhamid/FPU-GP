
module Exponent_Difference(
    input wire [7:0] Ex, 
    input wire [7:0] Ey,
    output reg [7:0]  d,
    output reg sgn_d,zero_d
    );
	reg [7:0] difference ; 
	reg carry ;
	reg ay7aga ;
always@(*)
begin
   {carry,difference}= Ex + ~Ey + 1'b1 ; 
   if (carry) 
	begin
		{ay7aga,d}= ~difference + 1'b1 ;
	end
	else 
		begin
		d=difference ;
		ay7aga= 1'b0 ; 
		end
		
			
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
