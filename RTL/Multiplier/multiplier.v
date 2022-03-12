module multiplier 
(
input 	wire 	        zero_Ex,zero_Ey,
input	wire	[22:0]	Mx,
input	wire 	[22:0]	My,
output	wire	[47:0]	P
);

wire [23:0]  Mx1,My1;

assign Mx1 = zero_Ex ? {1'b0,Mx} : {1'b1,Mx} ;
assign My1 = zero_Ey ? {1'b0,My} : {1'b1,My} ;


assign P = Mx1 * My1 ;

endmodule