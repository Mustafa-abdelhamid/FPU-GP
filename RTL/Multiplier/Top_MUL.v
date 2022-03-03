module Top_MUL(
input     wire   [7:0]        Ex,Ey,
input     wire   [22:0]       Mx,My,
input     wire                Sx,Sy,
input	  wire	 [1:0] 		  R_mode , ////
output    wire   [7:0]        Ez,
output    wire   [22:0]       Mz,
output    wire                Sz,
output	  wire  invalid_flag,overflow_flag,underflow_flag,inexact_flag,zero_flag

);

wire		T;


Rounding R0 (
.T(T),
.G(),
.L(),
.Sz(Sz),
.R_mode(R_mode),
.After_norm(),
.Overflow_after_round(),
.Mz(Mz),
.rnd()

);


sticky_bit T0(

leastbits(),
sticky(T)
);







endmodule