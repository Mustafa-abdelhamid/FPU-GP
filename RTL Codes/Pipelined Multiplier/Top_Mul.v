module Top_Mul 

(
input 	wire 	[7:0]	Ex,Ey, 
input 	wire 	[22:0]	Mx,My,
input 	wire 	     	Sx,Sy,
input 	wire 	[1:0]	R_mode, 
input  	wire 			CLK,RST,Enable, 
output 	wire 	[22:0]	Mz,
output 	wire 	[7:0]	Ez,
output 	wire 		    Sz,
output	wire 			invalid_flagex, overflow_flagex,
						underflow_flagex,inexact_flagex,zero_flagex ////////
);

//internal signals
wire [23:0]		Mx_conc,My_conc;

wire invalid_flag;
wire overflow_flag;
wire inexact_flag;
wire [9:0]Ez_add;
wire Sz_int; 
wire ovf;
wire ovf_rnd;
wire [4:0]reqiredShift_left;

wire	[7:0]	E_exponent_update;
wire 			overflow_case;
wire 	[47:0]	P;
wire	[24:0]	normalised_output;
wire 			sticky;
wire 	[23:0]	Mz_rounding;
wire			initial_zero_flag;

wire	[46:0]		after_sh_norm;

wire 				underflow_flag;



Exponent_addition	Exponent_addition_inst (
.CLK(CLK),
.RST(RST),
.Enable(Enable),
.Ex_ext(Ex),
.Ey_ext(Ey),
.Mx_ext(Mx),
.My_ext(My),
.Mx_conc(Mx_conc),
.My_conc(My_conc),
.Ez_add(Ez_add)
);

multiplier  	    multiplier_inst (
.CLK(CLK),
.RST(RST),
.Mx_conc(Mx_conc),
.My_conc(My_conc), 
.P(P)
);


normalization  	    normalization_inst(
.CLK(CLK),
.RST(RST),
.P(P),
.Ez_add(Ez_add), 
.normalised_output(normalised_output),
.SHL(reqiredShift_left),
.ovf(ovf),
.after_sh_norm(after_sh_norm)
);


sticky_bit          sticky_bit_inst (
.CLK(CLK),
.RST(RST),
.leastbits(after_sh_norm[22:0]),
.Mul_MSB(P[47]),
.Ez_add_MSB(Ez_add[9]),
.sticky(sticky)
);

Rounding 		    Rounding_inst (
.CLK(CLK),
.RST(RST),
.T(sticky),
.Sz(Sz_int), 
.R_mode_ext(R_mode), 
.After_norm(normalised_output),
.Overflow_after_round(ovf_rnd),
.Mz(Mz_rounding),
.inexact_flag(inexact_flag)
);



Exponent_Update		Exponent_Update_inst (
.CLK(CLK),
.RST(RST),
.Ez_add(Ez_add),
.ovf(ovf),
.ovf_rnd(ovf_rnd),
.SHL(reqiredShift_left),
.Ez(E_exponent_update),
.underflow_case(underflow_flag),///////
.overflow_case(overflow_case)
);




exceptions 		    exceptions_inst (
.CLK(CLK),
.RST(RST),
.Ex_ext(Ex),
.Ey_ext(Ey),
.Ez(E_exponent_update),
.Mx_ext(Mx), 
.My_ext(My),
.Mz(Mz_rounding),
.overflow_case(overflow_case), 
.invalid_flag(invalid_flag),
.overflow_flag(overflow_flag),
.initial_zero_flag(initial_zero_flag)
);

final_output 	    final_output_inst (
.CLK(CLK),
.RST(RST),
.M_out(Mz_rounding),
.E_out(E_exponent_update),
.Sz_out (Sz_int),
.overflow_flag(overflow_flag),
.underflow_case(underflow_flag),
.invalid_flag(invalid_flag), 
.initial_zero_flag(initial_zero_flag),
.inexact_flag(inexact_flag),
.final_M_out(Mz), 
.final_E_out(Ez),
.final_Sz_out(Sz),
.invalid_flag_ext(invalid_flagex),
.overflow_flag_ext(overflow_flagex),
.zero_flag_ext(zero_flagex),
.underflow_flag_ext(underflow_flagex),
.inexact_flag_ext(inexact_flagex)
);

sign     sign_Z (
.CLK(CLK),
.RST(RST),
.Enable(Enable),
.Sx_ext(Sx),
.Sy_ext(Sy),
.Sz(Sz_int)
);

	
endmodule	
