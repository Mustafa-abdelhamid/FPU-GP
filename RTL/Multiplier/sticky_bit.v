module sticky_bit 
(
input 	wire 	[22:0] leastbits,
output  wire		   sticky 
);

assign sticky = |leastbits ;

endmodule



