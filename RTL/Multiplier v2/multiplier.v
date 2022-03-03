module multiplier 
(
input	wire	[23:0]	Mx,
input	wire 	[23:0]	My,
output	wire		[47:0]	P
);


assign P = Mx *	My ;

endmodule