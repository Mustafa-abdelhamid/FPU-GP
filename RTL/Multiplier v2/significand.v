module significand
(
input     wire   [23:0]       Mx,My,
input	  wire	 [1:0] 		  R_mode ,
input     wire  			  Sz,
output    wire   [22:0]       Mz,
output	  wire				  ovf,
output	  wire	 [4:0]		  SHL,
output	  wire				  Overflow_after_round
);


wire	[47:0]	P;

wire		    T;

wire	[24:0]	N;






multiplier m1 
(
.Mx(Mx),
.My(My),
.P(P)
);

sticky_bit S1 
(
.leastbits(P[22:0]),
.Mul_MSB (P[47]),
.sticky(T)
);



Rounding R0 
(
.T(T),
.Sz(Sz),
.R_mode(R_mode),
.After_norm(N),
.Overflow_after_round(Overflow_after_round),
.Mz(Mz)
);

normalization N1
(
.MSB_multiplier_output( P[47:22] ),
.normalised_output ( N[24:0] ),
.SHL(SHL),
.ovf(ovf)
);

endmodule