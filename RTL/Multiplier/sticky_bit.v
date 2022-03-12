module sticky_bit 
(
input 	wire 	[22:0] leastbits,
input	wire 		   Mul_MSB,
output  wire		   sticky 
);

assign sticky = (Mul_MSB) ? |leastbits : |leastbits[21:0] ;

endmodule