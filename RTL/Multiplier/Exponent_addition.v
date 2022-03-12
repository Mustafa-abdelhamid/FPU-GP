module Exponent_addition 
(
input 	wire 	[7:0]	Ex,Ey, 
output  wire             zero_Ex,zero_Ey,
output  reg     [9:0]        Ez_add
//output  reg                zero_caseflag

);

//reg   [8:0]     Ez;

assign zero_Ex = ~| Ex ;
assign zero_Ey = ~| Ey ;


always @ (*) 
	begin
		Ez_add = Ex + Ey + 10'b 1110000001 ;
		
	/*	if (Ez < -8'd23)    to be handeld in exception block 
			begin 
				Ez_add = 8'b0;
				zero_caseflag= 1'b1;
			end
		else 3
			begin
				Ez_add = Ez[7:0];
				zero_caseflag= 1'b0;
			end
	*/
	
	end


endmodule