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

/// significand outputs
wire				  ovf;
wire	 [4:0]		  SHL;
wire     [23:0]       Mz_internal;
wire				  Overflow_after_round;


///output Exponent update 

wire	[4:0] mantissaReqiredModify;
wire          overflow_case ;
wire    [7:0] Ez_internal;

///output of exceptions 
wire  invalid_flag1,overflow_flag1,zero_flag1;



assign invalid_flag		= invalid_flag1 ;
assign overflow_flag 	= overflow_flag1 ;
assign zero_flag		= zero_flag1 ;




Exponent_addition Exp_add1 
(
.Ex(Ex),
.Ey(Ey),
.zero_Ex(zero_Ex),
.zero_Ey(zero_Ey),
.Ez_add (Ez_add)
);

significand Sig11
(
.Mx(Mx),
.My(My),
.zero_Ex(zero_Ex),
.zero_Ey(zero_Ey),
.R_mode(R_mode),
.Sz(Sz),
.Mz(Mz_internal),  
.ovf(ovf),
.SHL(SHL),
.Overflow_after_round(Overflow_after_round),
.inexact_flag(inexact_flag)
);





Exponent_Update Exp_update11 
(
.maxOf_Ex_Ey(Ez_add),
.ovf(ovf),
.ovf_rnd(Overflow_after_round),
.reqiredShift_left(SHL),
.mantissaReqiredModify(mantissaReqiredModify),
.Ez(Ez_internal),
.underflow_flag(underflow_flag),
.overflow_case(overflow_case)
);


exceptions Excep11 
(
.Ex(Ex),
.Ey(Ey),
.Ez(Ez_internal),
.Mx(Mx),
.My(My),
.Mz(Mz_internal[22:0]),
.required_shift(SHL),
.invalid_flag(invalid_flag1),
.overflow_flag(overflow_flag1),
.zero_flag(zero_flag1),
.mantissaReqiredModify(mantissaReqiredModify),
.overflow_case(overflow_case)
);


final_output Multiplier_output 
(
.M_out(Mz_internal[22:0]),
.E_out(Ez_internal),
.required_shift(SHL),
.invalid_flag(invalid_flag1),
.overflow_flag(overflow_flag1),
.underflow_flag(underflow_flag1),
.zero_flag(zero_flag1),
.final_M_out(Mz),
.final_E_out(Ez)
);


endmodule