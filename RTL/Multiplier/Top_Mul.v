module Top_Mul 
(
input 	wire 	[7:0]	Ex_ext,Ey_ext, 
input 	wire 	[22:0]	Mx_ext,My_ext,
input 	wire 	     	Sx_ext,Sy_ext,
input 	wire 	[1:0]	R_mode_ext, 
input 	wire 	[1:0]	Mul_enable,
input  	wire 			CLK,RST, 
output 	reg 	[22:0]	Mz_ext,
output 	reg 	[7:0]	Ez_ext,
output 	reg 		    Sz_ext,
output	reg  invalid_flag_ext,overflow_flag_ext,underflow_flag_ext,inexact_flag_ext,zero_flag_ext ////////
);

//Flip_Flops 
//inputs
reg 	[7:0]	Ex,Ey;
reg 	[22:0]	Mx,My;
reg 	     	Sx,Sy;
reg 	[1:0]	R_mode;

//outputs
wire 	[22:0]	Mz; 	
wire 	[7:0]	Ez;
wire 		    Sz;
wire  			invalid_flag,overflow_flag,underflow_flag,inexact_flag,zero_flag; ////////


//internal signals
wire zero_Ex;
wire zero_Ey;
wire [9:0]Ez_add;
wire ovf;
wire ovf_rnd;
wire [4:0]reqiredShift_left;
wire [7:0]mantissaReqiredModify;
wire [7:0]E_exponent_update;
wire overflow_case;
wire [47:0]P;
wire [24:0]normalised_output;
wire sticky;
wire [23:0]Mz_rounding;
wire initial_zero_flag;

//asssignments
assign Sz = Sx ^ Sy;



always @ (posedge CLK or negedge RST)
	begin 
		if (!RST) 
		begin
////////inputs RST
		Ex		<=	0;
		Ey		<=	0;
		Mx		<=	0;
		My		<=	0;
		Sx		<=	0;
		Sy		<=	0;
		R_mode	<=	0;		 
////////outputs RST
		Mz_ext				<=	0;
		Ez_ext				<=	0;
		Sz_ext				<=	0;
		invalid_flag_ext	<=	0;
		overflow_flag_ext	<=	0;
		underflow_flag_ext	<=	0;
		inexact_flag_ext	<=	0;
		zero_flag_ext		<=	0;
		end
		
		else
		begin
////////inputs Reg
		Ex		<=	Ex_ext;
		Ey		<=	Ey_ext;
		Mx		<=	Mx_ext;
		My		<=	My_ext;
		Sx		<=	Sx_ext;
		Sy		<=	Sy_ext;
		R_mode	<=	R_mode_ext;		 
////////outputs Reg
		Mz_ext				<=	Mz;
		Ez_ext				<=	Ez;
		Sz_ext				<=	Sz;
		invalid_flag_ext	<=	invalid_flag;
		overflow_flag_ext	<=	overflow_flag;
		underflow_flag_ext	<=	underflow_flag;
		inexact_flag_ext	<=	inexact_flag;
		zero_flag_ext		<=	zero_flag;
		end		
		
	end 	






//instances
Exponent_addition Exponent_addition_inst (Ex , Ey , zero_Ex , zero_Ey , Ez_add);
Exponent_Update Exponent_Update_inst (Ez_add , ovf , ovf_rnd , reqiredShift_left , mantissaReqiredModify , E_exponent_update , underflow_flag , overflow_case);
multiplier multiplier_inst (zero_Ex , zero_Ey , Mx , My , P);
normalization normalization_inst(P[47:22] , normalised_output , reqiredShift_left , ovf);
sticky_bit sticky_bit_inst (P[22:0] , P[47] , sticky);
Rounding Rounding_inst (sticky , Sz , R_mode , normalised_output , ovf_rnd , Mz_rounding , inexact_flag);
exceptions exceptions_inst (Ex , Ey , E_exponent_update , Mx , My , Mz_rounding , mantissaReqiredModify , overflow_case , invalid_flag , overflow_flag , initial_zero_flag);
final_output final_output_inst (Mz_rounding , E_exponent_update , mantissaReqiredModify , overflow_flag , underflow_flag , invalid_flag , Mz , Ez);
zero_flag_block M_out_inst (Mz , Ez , initial_zero_flag , zero_flag);










































/*
// exponent addition outputs
wire     [9:0]        Ez_add ;
wire                 zero_Ex,zero_Ey;

/// significand outputs
wire				  ovf;
wire	 [4:0]		  SHL;
wire     [23:0]       Mz_internal;
wire				  Overflow_after_round;


///output Exponent update 

wire	[7:0] mantissaReqiredModify;
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
.required_shift(mantissaReqiredModify),
.invalid_flag(invalid_flag1),
.overflow_flag(overflow_flag1),
.underflow_flag(underflow_flag1),
.zero_flag(zero_flag1),
.final_M_out(Mz),
.final_E_out(Ez)
);
*/

endmodule