module Exponent_addition 

(
input  	wire 				CLK,RST, 
input 	wire 	[7:0]		Ex_ext,Ey_ext, 
input 	wire 	[22:0]		Mx_ext,My_ext,

output	wire	[23:0]		Mx_conc,My_conc,	
output  reg     [9:0]       Ez_add
);

//internal signals
wire 	one_op_den;

wire            zero_Ex,zero_Ey;
wire            Conc_X,Conc_Y;

//Flip_Flops 
reg 	[7:0]	Ex,Ey;
reg 	[22:0]	Mx,My;


assign zero_Ex = ~| Ex ;
assign zero_Ey = ~| Ey ;

assign Conc_X = ~zero_Ex ;
assign Conc_Y = ~zero_Ey ;

assign Mx_conc = {Conc_X,Mx};
assign My_conc = {Conc_Y,My};



assign one_op_den = zero_Ex ^ zero_Ey;		


always @ (posedge CLK or negedge RST )
	begin
	if (!RST) 
		begin
////////inputs RST
			Ex 	<= 0;
			Ey 	<= 0;
			Mx	<= 0;
			My	<= 0;
		end
		
	else
		begin
////////inputs Reg
			Ex 	<= Ex_ext;
			Ey 	<= Ey_ext;
			Mx	<= Mx_ext;
			My	<= My_ext;
		end			
	end


always @ (*) 
	begin
		Ez_add = Ex + Ey + 10'b 1110000001 +one_op_den ; // -10'b127
	end


endmodule