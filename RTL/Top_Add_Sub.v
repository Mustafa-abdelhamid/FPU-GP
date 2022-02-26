module Top_Add_Sub (

input     wire   [7:0]        Ex,Ey,
input     wire   [22:0]       Mx,My,
input     wire                Sx,Sy,EOP,sub,
input	  wire	 [1:0] 		  roundMode , ////
output    wire   [7:0]        Ez,
output    wire   [22:0]       Mz,
output    wire                Sz,
output	  wire  invalid_flag,overflow_flag,underflow_flag,inexact_flag,zero_flag ////////
); 

wire  	    cmp;
wire        sgn_d;
wire        zero_d;
wire [7:0]  d;
wire [26:0] out_11;
wire [26:0] out_22;

wire [7:0]  Out_mux;

wire        ovf;
wire        ovf_rnd;
wire 		[7:0] Ez_pre ; 
wire max_exponent_z ;

wire [4:0]final_shift_left; 
wire [1:0]rightpath_exponent_update_control;
wire  [2:0]  most_bits_of_adder_out ;
Alignment A1 (
.Mx(Mx),
.My(My),
.sgn_d(sgn_d), 
.EOP(EOP),
.zero_d(zero_d),
.Ex(Ex),
.Ey(Ey),
.d(d),
.out_11(out_11),
.out_22(out_22),
.Cmp(cmp)
);

Exponent_Difference Ex_Diff (
.Ex(Ex),
.Ey(Ey),
.sgn_d(sgn_d),
.zero_d(zero_d),
.d(d)
);


Mux mux11 (
.Ex(Ex),
.Ey(Ey),
.sgn_d(sgn_d),
.Out_mux(Out_mux)
);
Exponent_shifter Ex_shifter (
.E (Out_mux),
.L_shift_value (final_shift_left), 
.selection ( ~| most_bits_of_adder_out),
.L_or_R(rightpath_exponent_update_control) ,
.Ez_pre(Ez_pre)
);
Exponent_Update Ex_update (
.Mux_Out(Ez_pre),
.Ez(Ez),
.ovf(ovf),
.ovf_rnd(ovf_rnd)
);
assign max_exponent_z= &Ez ; 

Sign_of_z sign_z11 (
.Sx(Sx),
.Sy(Sy),
.EOP(EOP),
.cmp(cmp),
.sign_d(sgn_d),
.zero_d(zero_d),
.Sz(Sz)
);

exceptions exceptions_block
 (.Ex (Ex),
 .Ey(Ey),
 .Mx(Mx),
 .My(My),
 .Mz(Mz),
 .EOP(EOP),
 .exponent_z(Ez),
 .required_shift(final_shift_left) ,
 .invalid_flag(invalid_flag),
 .overflow_flag(overflow_flag),
 .underflow_flag(underflow_flag),
 .inexat_flag(inexat_flag),
 .zero_flag(zero_flag),
 .max_exponent_z(max_exponent_z)
 );
 
top_part_three omar (
.Sign_in(Sz) ,
.roundMode(roundMode) ,
.A(out_11) ,
.B(out_22) ,
.sub (sub) ,

.ovf(ovf) , 
.ovf_rnd(ovf_rnd) ,
.final_shift_left(final_shift_left) , 
.rightpath_exponent_update_control(rightpath_exponent_update_control) ,
.overFlow(overflow_flag) ,
.inexact_flag(inexact_flag) , 
.final_M_out(Mz) ,
.final_E_out (Ez) ,
.most_bits_of_adder_out (most_bits_of_adder_out) 
 );
 
 endmodule