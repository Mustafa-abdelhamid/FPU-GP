`timescale 1ns/1ns
module special_test();
reg             rst_tb;
reg 			clk_tb;
reg		[7:0]	Ex_tb;
reg		[7:0]	Ey_tb;
wire	[7:0]	Ez_tb;
reg		[22:0]	Mx_tb;
reg		[22:0]	My_tb;
wire	[22:0]	Mz_tb;
reg				Sx_tb;			
reg				Sy_tb;			
wire			Sz_tb;	
//reg				Eop_tb;	
reg				sub_tb;							
wire  			invalid_flag_tb,overflow_flag_tb,underflow_flag_tb,inexact_flag_tb,zero_flag_tb;
reg	    [1:0]   roundMode_tb;


parameter CLK_PERIOD = 16 ;
parameter tclk = 16;
Top_Add_Sub		DUT (
.rst(rst_tb),
.clk(clk_tb),
.Mx(Mx_tb),
.My(My_tb),
.Mz_final(Mz_tb),
.Ex(Ex_tb),
.Ey(Ey_tb),
.Ez(Ez_tb),
.Sx(Sx_tb),
.Sy(Sy_tb),
.Sz(Sz_tb),
//.EOP(Eop_tb),
.sub(sub_tb),
.roundMode(roundMode_tb),
.invalid_flag(invalid_flag_tb),
.overflow_flag(overflow_flag_tb),
.underflow_flag(underflow_flag_tb),
.inexact_flag(inexact_flag_tb),
.zero_flag(zero_flag_tb)
///.d(d),
///.sgn_d(sgn_d),
///.zero_d(zero_d),
///.Cmp(Cmp),
///.out_11(out_11),
///.out_22(out_22),
///.EOP(EOP),
///.sum(sum),
///.ovf_rnd(ovf_rnd),
///.Out_mux(Out_mux),
///.massive_shift_left(massive_shift_left),
//.correct_sum_shifted(correct_sum_shifted),
///.ovf(ovf),
///.righPass_shift_out(righPass_shift_out),
///.one_shift_left(one_shift_left),
///.most_bits_of_adder_out(most_bits_of_adder_out),
///.mantessa_mux_out(mantessa_mux_out),
///.MOut(MOut),
///.E_exponent_update(E_exponent_update),
///.max_exponent_z(max_exponent_z),
///.min_exponent_z(min_exponent_z),
///.excessive_shift_left(excessive_shift_left),
///.SHL(SHL_tb),
///.second_shift_left(second_shift_left_tb)
///.Mz_final_int(Mz_final_int),
///.Sz_int(Sz_int)
);
initial clk_tb = 0;
always
#(tclk/2) clk_tb = ~clk_tb;
initial 
begin
   // succeeded = 0;
	//failed = 0;
	rst_tb = 0;
	#(tclk*10);//10clk - 10ns
	rst_tb = 1;	
	#tclk;
	rst_tb = 0;
	#tclk;
    Ex_tb = 8'b 11110000;
    Mx_tb = 23'b 11100000000000000000000;
    Sx_tb = 1'b 0;
    Ey_tb = 8'b 11110000;
    My_tb = 23'b 11100000000000000000000;
    Sy_tb = 1'b 0;
    sub_tb = 1'b 1;
    roundMode_tb = 2'b 00;
end
endmodule