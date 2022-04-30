module Exponent_addition 

(
input  	wire 				CLK,RST, 
input 	wire 	[7:0]		Ex_ext,Ey_ext, 
output  wire             	zero_Ex,zero_Ey,
output  reg     [9:0]       Ez_add
);

//internal signals
wire 	one_op_den;

//Flip_Flops 
reg 	[7:0]	Ex,Ey;

assign zero_Ex = ~| Ex ;
assign zero_Ey = ~| Ey ;
assign one_op_den = zero_Ex ^ zero_Ey;		


always @ (posedge CLK or negedge RST )
	begin
	if (!RST) 
		begin
////////inputs RST
			Ex <= 0;
			Ey <= 0;
		end
		
	else
		begin
////////inputs Reg
			Ex <= Ex_ext;
			Ey <= Ey_ext;
		end			
	end


always @ (*) 
	begin
		Ez_add = Ex + Ey + 10'b 1110000001 +one_op_den ; // -10'b127
	end


endmodule