module Top_Mul 
(
input 	wire 	[7:0]	Ex,Ey, 
input 	wire 	[22:0]	Mx,My,
input 	wire 	     	Sx,Sy,
input 	wire 	[1:0]	R_mode, 
input 	wire 	[1:0]	Mul_enable, 
output 	wire 	[23:0]	Mz,
output 	wire 	[7:0]	Ez,
output 	wire 		    Sz,
output	wire  invalid_flag,overflow_flag,underflow_flag,inexact_flag,zero_flag ////////
);

assign Sz = Sx^Sy;

// exponent addition outputs
wire     [7:0]        Ez_add ;
wire                 zero_Ex,zero_Ey;
wire                zero_caseflag;


/// significand outputs
wire				  ovf;
wire	 [4:0]		  SHL;
wire				  Overflow_after_round;


///output Exponent update 

wire	[4:0] mantissaReqiredModify;
wire          overflow_case ;





Exponent_addition Exp_add1 
(
.Ex(Ex),
.Ey(Ey),
.zero_Ex(zero_Ex),
.zero_Ey(zero_Ey),
.Ez_add (Ez_add),
.zero_caseflag(zero_caseflag)
);

significand Sig11
(
.Mx(Mx),
.My(My),
.zero_Ex(zero_Ex),
.zero_Ey(zero_Ey),
.R_mode(R_mode),
.Sz(Sz),
.Mz(Mz), /// not yet 
.ovf(ovf),
.SHL(SHL),
.Overflow_after_round(Overflow_after_round)
);





Exponent_Update Exp_update11 
(
.maxOf_Ex_Ey(Ez_add),
.ovf(ovf),
.ovf_rnd(Overflow_after_round),
.reqiredShift_left(SHL),
.mantissaReqiredModify(mantissaReqiredModify),
.Ez(Ez),
.underflow_flag(underflow_flag),
.overflow_case(overflow_case)
);







endmodule