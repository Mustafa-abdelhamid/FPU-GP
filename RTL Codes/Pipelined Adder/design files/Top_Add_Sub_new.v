module Top_Add_Sub_new (
//inputs and outputs
input     wire   [7:0]        Ex,Ey,
input     wire   [22:0]       Mx,My,
input     wire                Sx,Sy,sub,
input	  wire	 [1:0] 		  roundMode ,////
input     wire                rst , clk, enable,
output    wire   [7:0]        Ez,
output    wire   [22:0]       Mz_final,
output    wire                Sz,
output	  wire  invalid_flag,overflow_flag,underflow_flag,inexact_flag,zero_flag ////////
//outputs taken from Exponont_Difference
///output wire [7:0]d,
///output wire sgn_d,
///output wire zero_d,
//outputs taken from Alignment
///output wire Cmp,
///output wire [26:0]out_11,
///output wire [26:0]out_22,
//outputs taken from adder_modified
///output wire EOP,
///output wire [26:0]sum,
///output wire ovf_rnd,
//outputs taken from mux
///output wire [7:0]Out_mux,
//outputs taken from LZA_massive_SHL
///output wire [4:0]massive_shift_left,
///output wire [55:0]correct_sum_shifted,
//outputs taken from left_right_shifter
///output wire ovf,
///output wire [26:0]righPass_shift_out,
///output wire one_shift_left,
//outputs taken from mantessa_mux
///output wire [2:0]most_bits_of_adder_out,
///output wire [55:0]mantessa_mux_out,
//outputs taken from round
///output wire [23:0]MOut,
//outputs taken from exponent_update
///output wire [7:0]E_exponent_update,
///output wire max_exponent_z,
///output wire min_exponent_z,
///output wire [9:0]excessive_shift_left,
///outputs taken from submodule in LZA_and_massive_SHL
//output [26:0]E,
///output [4:0]SHL,       
///output [58:0]sum_shifted,   
///output second_shift_left,
///output [22:0]Mz_final_int,
///output Sz_int 
); 
//internal signals for input and output registers
wire [7:0]Ex_int,Ey_int;
wire [22:0]Mx_int,My_int;
wire Sx_int,Sy_int,sub_int;
wire [1:0]roundMode_int; ////
wire [7:0]Ez_int;
wire [22:0]Mz_final_int;
wire Sz_int;
wire invalid_flag_int ,overflow_flag_int , underflow_flag_int , inexact_flag_int , zero_flag_int;
//internal signals for metastability inputs registers
/*wire [7:0]Ex_int_2,Ex_int_3;
wire [7:0]Ey_int_2,Ey_int_3;
wire [22:0]Mx_int_2,Mx_int_3;
wire [22:0]My_int_2,My_int_3;
wire Sx_int_2,Sx_int_3;
wire Sy_int_2,Sy_int_3;
wire sub_int_2,sub_int_3;
wire [1:0]roundMode_int_2,roundMode_int_3;
*/
//internal signals
wire EOP;
wire [7:0]d;
wire sgn_d;
wire zero_d;
wire [7:0]Out_mux;
wire ovf;
wire ovf_rnd;
wire [4:0]massive_shift_left;
wire one_shift_left;
wire [7:0]E_exponent_update;
wire max_exponent_z;
wire min_exponent_z;
wire [9:0]excessive_shift_left;
wire Cmp;
wire [26:0]out_11;
wire [26:0]out_22;
wire [26:0]sum;
//wire [4:0]massive_shift_left;
wire [23:0]correct_sum_shifted;
wire [26:0]righPass_shift_out;
//wire one_shift_left;
wire [23:0]MOut;
wire [2:0]most_bits_of_adder_out;
wire [23:0]mantessa_mux_out;
wire [58:0]sum_shifted;
//optimization internal signals
wire [23:0]correct_sum_shifted_reg;
wire [23:0]MOut_reg;
wire [2:0]most_bits_of_adder_out_reg;
//
wire [7:0]Out_mux_reg;
wire [4:0]massive_shift_left_reg;
wire ovf_rnd_reg;
wire one_shift_left_reg;
wire ovf_reg;
wire [26:0]sum_reg;
//
wire [7:0]Ex_int_reg;
wire [7:0]Ey_int_reg;
wire EOP_reg;
wire [22:0]Mx_int_reg;
wire [22:0]My_int_reg;
//
wire Sz_int_out_reg;
//
wire inexact_flag_int_out_reg;
//
wire [26:0]out_11_reg;
wire [26:0]out_22_reg;
wire EOP_reg_2;
//
wire Sz_int_reg_2;
wire [1:0]roundMode_int_reg_2;
//
wire [7:0]Out_mux_reg_2;
//
wire [7:0]Ex_int_reg_2;
wire [7:0]Ey_int_reg_2;
wire EOP_reg_2_exceptions;
wire [22:0]Mx_int_reg_2;
wire [22:0]My_int_reg_2;
//
wire Sz_int_out_reg_2;
//
wire [22:0]Mx_int_reg_3;
wire [22:0]My_int_reg_3;
wire [7:0]d_reg_3;
wire [7:0]Ex_int_reg_3;
wire [7:0]Ey_int_reg_3;
wire sgn_d_reg_3;
wire EOP_reg_3;
wire zero_d_reg_3;
//
wire EOP_reg_3_adder_modified;
//
wire EOP_reg_3_sign_z;
wire sgn_d_reg_3_sign_z;
wire zero_d_reg_3_sign_z;
wire Sx_int_reg_3;
wire Sy_int_reg_3;
//
wire [1:0]roundMode_int_reg_3;
//
wire [7:0]Out_mux_reg_3;
//
wire [7:0]Ex_int_reg_3_exceptions;
wire [7:0]Ey_int_reg_3_exceptions;
wire EOP_reg_3_exceptions;
wire [22:0]Mx_int_reg_3_exceptions;
wire [22:0]My_int_reg_3_exceptions;
//
wire [26:0]sum_reg_4;
wire [26:0]out_11_reg_4;
wire [26:0]out_22_reg_4;
//
wire [2:0]most_bits_of_adder_out_reg_4;
wire [23:0]MOut_reg_4;
//
wire [26:0]sum_reg_4_Exponent_Update;
wire ovf_reg_4;
wire one_shift_left_reg_4;
wire ovf_rnd_reg_4;
wire [7:0]Out_mux_reg_4;
//
wire [7:0]Ex_int_reg_4_exceptions;
wire [7:0]Ey_int_reg_4_exceptions;
wire EOP_reg_4_exceptions;
wire [22:0]Mx_int_reg_4_exceptions;
wire [22:0]My_int_reg_4_exceptions;
//
wire Sz_int_out_reg_4;
wire inexact_flag_int_out_reg_4;
//
wire [7:0]Ex_int_reg_5_exceptions;
wire [7:0]Ey_int_reg_5_exceptions;
wire EOP_reg_5_exceptions;
wire [22:0]Mx_int_reg_5_exceptions;
wire [22:0]My_int_reg_5_exceptions;
wire max_exponent_z_reg_5;
//
wire [23:0]mantessa_mux_out_reg_5;
wire [7:0]E_exponent_update_reg_5;
wire [9:0]excessive_shift_left_reg_5;
wire underflow_flag_int_reg_5;
//
wire min_exponent_z_reg_5;
//
wire Sz_int_out_reg_5;
wire underflow_flag_int_out_reg_5;
wire inexact_flag_int_out_reg_5;
//
wire [7:0]Out_mux_reg_6;
wire [23:0]mantessa_mux_out_reg_6;
wire [4:0]massive_shift_left_reg_6;
wire ovf_rnd_reg_6;
wire one_shift_left_reg_6;
wire ovf_reg_6;
wire [26:0]sum_reg_6_Exponent_Update;
//
wire [7:0]Ex_int_reg_6_exceptions;
wire [7:0]Ey_int_reg_6_exceptions;
wire EOP_reg_6_exceptions;
wire [22:0]Mx_int_reg_6_exceptions;
wire [22:0]My_int_reg_6_exceptions; 
//
wire [23:0]mantessa_mux_out_reg_6_final_output;
//
wire Sz_int_out_reg_6;
wire inexact_flag_int_out_reg_6;
//
wire [26:0]sum_reg_7;
wire ovf_reg_7;
//
wire Sz_int_reg_7;
wire [1:0]roundMode_int_reg_7; 
//
wire [23:0]correct_sum_shifted_reg_7;
wire [2:0]most_bits_of_adder_out_reg_7;
//
wire [7:0]Out_mux_reg_7;
wire [4:0]massive_shift_left_reg_7;
wire [26:0]sum_reg_7_Exponent_Update;
//
wire [7:0]Ex_int_reg_7_exceptions;
wire [7:0]Ey_int_reg_7_exceptions;
wire EOP_reg_7_exceptions;
wire [22:0]Mx_int_reg_7_exceptions;
wire [22:0]My_int_reg_7_exceptions; 
//
wire Sz_int_out_reg_7;
//
wire Cmp_reg_8;
wire EOP_reg_8_sign_z;
wire sgn_d_reg_8_sign_z;
wire zero_d_reg_8_sign_z;
wire Sx_int_reg_8;
wire Sy_int_reg_8;
//
wire [1:0]roundMode_int_reg_8; 
wire [26:0]righPass_shift_out_reg_8;
//
wire [23:0]correct_sum_shifted_reg_8;
wire [2:0]most_bits_of_adder_out_reg_8;
//
wire [26:0]sum_reg_8_Exponent_Update;
wire ovf_reg_8;
wire one_shift_left_reg_8;
wire [4:0]massive_shift_left_reg_8;
wire [7:0]Out_mux_reg_8;
//
wire [7:0]Ex_int_reg_8_exceptions;
wire [7:0]Ey_int_reg_8_exceptions;
wire EOP_reg_8_exceptions;
wire [22:0]Mx_int_reg_8_exceptions;
wire [22:0]My_int_reg_8_exceptions; 
//
wire [7:0]Ex_int_reg_9;
wire sgn_d_reg_9;
wire [7:0]Ey_int_reg_9;
wire [23:0]mantessa_mux_out_reg_9;
wire [4:0]massive_shift_left_reg_9;
wire ovf_rnd_reg_9;
wire one_shift_left_reg_9;
wire ovf_reg_9;
wire [26:0]sum_reg_9_Exponent_Update;
//
wire [7:0]Ex_int_reg_9_exceptions;
wire [7:0]Ey_int_reg_9_exceptions;
wire EOP_reg_9_exceptions;
wire [22:0]Mx_int_reg_9_exceptions;
wire [22:0]My_int_reg_9_exceptions;
//
wire inexact_flag_int_out_reg_9;
wire Sz_int_out_reg_9;
//
wire [23:0]mantessa_mux_out_reg_9_final_output;
//
wire [23:0]mantessa_mux_out_reg_10_final_output;
wire [7:0]E_exponent_update_reg_10;
wire invalid_flag_int_reg_10;
wire overflow_flag_int_reg_10;
wire [9:0]excessive_shift_left_reg_10;
wire underflow_flag_int_reg_10;
//
wire min_exponent_z_reg_10;
//
wire invalid_flag_int_out_reg_10;
wire Sz_int_out_reg_10;
wire overflow_flag_int_out_reg_10;
wire underflow_flag_int_out_reg_10;
wire inexact_flag_int_out_reg_10;
//
wire min_exponent_z_reg_11;
wire [22:0]Mz_final_int_reg_11;
//
wire invalid_flag_int_out_reg_11;
wire Sz_int_out_reg_11;
wire [22:0]Mz_final_int_out_reg_11;
wire [7:0]Ez_int_out_reg_11;
wire overflow_flag_int_out_reg_11;
wire underflow_flag_int_out_reg_11;
wire inexact_flag_int_out_reg_11;
//RTL optimization internal signals
wire EOP_rtl_1;
wire EOP_rtl_2;
wire EOP_rtl_3;
wire EOP_rtl_4;
wire EOP_rtl_5;
wire EOP_rtl_6;
wire EOP_rtl_7;
wire sgn_d_rtl_1;
wire sgn_d_rtl_2;
wire sgn_d_rtl_3;
wire sgn_d_rtl_4;
wire sgn_d_rtl_5;
wire sgn_d_rtl_6;
wire sgn_d_rtl_7;
wire zero_d_rtl_1;
wire zero_d_rtl_2;
wire zero_d_rtl_3;
wire zero_d_rtl_4;
wire zero_d_rtl_5;
wire zero_d_rtl_6;
wire zero_d_rtl_7;
wire Sy_int_rtl_1;
wire Sy_int_rtl_2;
wire Sy_int_rtl_3;
wire Sy_int_rtl_4;
wire Sy_int_rtl_5;
wire Sy_int_rtl_6;
wire Sy_int_rtl_7;
wire Sx_int_rtl_1;
wire Sx_int_rtl_2;
wire Sx_int_rtl_3;
wire Sx_int_rtl_4;
wire Sx_int_rtl_5;
wire Sx_int_rtl_6;
wire Sx_int_rtl_7;
wire [1:0]roundMode_int_rtl_1;
wire [1:0]roundMode_int_rtl_2;
wire [1:0]roundMode_int_rtl_3;
wire [1:0]roundMode_int_rtl_4;
wire [1:0]roundMode_int_rtl_5;
wire [1:0]roundMode_int_rtl_6;
wire [1:0]roundMode_int_rtl_7;
wire [22:0]Mx_int_rtl_1;
wire [22:0]Mx_int_rtl_2;
wire [22:0]Mx_int_rtl_3;
wire [22:0]Mx_int_rtl_4;
wire [22:0]Mx_int_rtl_5;
wire [22:0]Mx_int_rtl_6;
wire [22:0]Mx_int_rtl_7;
wire [22:0]My_int_rtl_1;
wire [22:0]My_int_rtl_2;
wire [22:0]My_int_rtl_3;
wire [22:0]My_int_rtl_4;
wire [22:0]My_int_rtl_5;
wire [22:0]My_int_rtl_6;
wire [22:0]My_int_rtl_7;
wire [7:0]Ey_int_rtl_1;
wire [7:0]Ey_int_rtl_2;
wire [7:0]Ey_int_rtl_3;
wire [7:0]Ey_int_rtl_4;
wire [7:0]Ey_int_rtl_5;
wire [7:0]Ey_int_rtl_6;
wire [7:0]Ey_int_rtl_7;
wire [7:0]Ex_int_rtl_1;
wire [7:0]Ex_int_rtl_2;
wire [7:0]Ex_int_rtl_3;
wire [7:0]Ex_int_rtl_4;
wire [7:0]Ex_int_rtl_5;
wire [7:0]Ex_int_rtl_6;
wire [7:0]Ex_int_rtl_7;
wire [7:0]Out_mux_rtl_1;
wire [7:0]Out_mux_rtl_2;
wire [7:0]Out_mux_rtl_3;
wire [7:0]Out_mux_rtl_4;
wire [7:0]Out_mux_rtl_5;
wire [7:0]Out_mux_rtl_6;
wire [7:0]Out_mux_rtl_7;
wire [2:0]most_bits_of_adder_out_rtl_1;
wire [2:0]most_bits_of_adder_out_rtl_2;
wire [2:0]most_bits_of_adder_out_rtl_3;
wire [2:0]most_bits_of_adder_out_rtl_4;
wire one_shift_left_rtl_1;
wire one_shift_left_rtl_2;
wire one_shift_left_rtl_3;
wire one_shift_left_rtl_4;
wire ovf_rtl_1;
wire ovf_rtl_2;
wire ovf_rtl_3;
wire ovf_rtl_4;
wire [26:0]sum_rtl_1;
wire [26:0]sum_rtl_2;
wire [26:0]sum_rtl_3;
wire [26:0]sum_rtl_4;
wire [23:0]MOut_rtl_1;
wire [23:0]MOut_rtl_2;
wire [23:0]MOut_rtl_3;
wire [23:0]MOut_rtl_4;
wire [7:0]Out_mux_rtl_8;
wire [7:0]Out_mux_rtl_9;
wire [7:0]Out_mux_rtl_10;
wire [7:0]Out_mux_rtl_11;
wire [7:0]Ex_int_rtl_8;
wire [7:0]Ex_int_rtl_9;
wire [7:0]Ex_int_rtl_10;
wire [7:0]Ex_int_rtl_11;
wire [7:0]Ey_int_rtl_8;
wire [7:0]Ey_int_rtl_9;
wire [7:0]Ey_int_rtl_10;
wire [7:0]Ey_int_rtl_11;
wire [22:0]Mx_int_rtl_8;
wire [22:0]Mx_int_rtl_9;
wire [22:0]Mx_int_rtl_10;
wire [22:0]Mx_int_rtl_11;
wire [22:0]My_int_rtl_8;
wire [22:0]My_int_rtl_9;
wire [22:0]My_int_rtl_10;
wire [22:0]My_int_rtl_11;
wire EOP_rtl_8;
wire EOP_rtl_9;
wire EOP_rtl_10;
wire EOP_rtl_11;
wire Sz_int_rtl_1;
wire Sz_int_rtl_2;
wire Sz_int_rtl_3;
wire Sz_int_rtl_4;
wire inexact_flag_int_rtl_1;
wire inexact_flag_int_rtl_2;
wire inexact_flag_int_rtl_3;
wire inexact_flag_int_rtl_4;
wire ovf_rnd_rtl_1;
wire ovf_rnd_rtl_2;
wire ovf_rnd_rtl_3;
wire ovf_rnd_rtl_4;
//internal signals for rtl opt 2
wire [22:0]Mx_int_opt_2_rtl_1;
wire [22:0]Mx_int_opt_2_rtl_2;
wire [22:0]Mx_int_opt_2_rtl_3;
wire [22:0]Mx_int_opt_2_rtl_4;

wire [22:0]My_int_opt_2_rtl_1;
wire [22:0]My_int_opt_2_rtl_2;
wire [22:0]My_int_opt_2_rtl_3;
wire [22:0]My_int_opt_2_rtl_4;

wire [7:0]Ex_int_opt_2_rtl_1;
wire [7:0]Ex_int_opt_2_rtl_2;
wire [7:0]Ex_int_opt_2_rtl_3;
wire [7:0]Ex_int_opt_2_rtl_4;

wire [7:0]Ey_int_opt_2_rtl_1;
wire [7:0]Ey_int_opt_2_rtl_2;
wire [7:0]Ey_int_opt_2_rtl_3;
wire [7:0]Ey_int_opt_2_rtl_4;

wire Sx_int_opt_2_rtl_1;
wire Sx_int_opt_2_rtl_2;
wire Sx_int_opt_2_rtl_3;

wire Sy_int_opt_2_rtl_1;
wire Sy_int_opt_2_rtl_2;
wire Sy_int_opt_2_rtl_3;

wire EOP_opt_2_rtl_1;
wire EOP_opt_2_rtl_2;
wire EOP_opt_2_rtl_3;
wire EOP_opt_2_rtl_4;

wire [1:0]roundMode_int_opt_2_rtl_1;
wire [1:0]roundMode_int_opt_2_rtl_2;
wire [1:0]roundMode_int_opt_2_rtl_3;

wire [23:0]mantessa_mux_out_opt_2_rtl_1;

wire Sz_int_opt_2_rtl_1;

wire inexact_flag_int_opt_2_rtl_1;
//internal signals for rtl opt 3
wire [2:0]most_bits_of_adder_out_rtl_opt_3_reg_1;
wire [2:0]most_bits_of_adder_out_rtl_opt_3_reg_2;
wire [2:0]most_bits_of_adder_out_rtl_opt_3_reg_3;
wire [2:0]most_bits_of_adder_out_rtl_opt_3_reg_4;
wire [2:0]most_bits_of_adder_out_rtl_opt_3_reg_5;

wire [23:0]correct_sum_shifted_rtl_opt_3_reg_1;
wire [23:0]correct_sum_shifted_rtl_opt_3_reg_2;
wire [23:0]correct_sum_shifted_rtl_opt_3_reg_3;
wire [23:0]correct_sum_shifted_rtl_opt_3_reg_4;
wire [23:0]correct_sum_shifted_rtl_opt_3_reg_5;

wire one_shift_left_rtl_opt_3_reg_1;
wire one_shift_left_rtl_opt_3_reg_2;
wire one_shift_left_rtl_opt_3_reg_3;
wire one_shift_left_rtl_opt_3_reg_4;
wire one_shift_left_rtl_opt_3_reg_5;

wire ovf_rtl_opt_3_reg_1;
wire ovf_rtl_opt_3_reg_2;
wire ovf_rtl_opt_3_reg_3;
wire ovf_rtl_opt_3_reg_4;
wire ovf_rtl_opt_3_reg_5;

wire [26:0]sum_rtl_opt_3_reg_1;
wire [26:0]sum_rtl_opt_3_reg_2;
wire [26:0]sum_rtl_opt_3_reg_3;
wire [26:0]sum_rtl_opt_3_reg_4;
wire [26:0]sum_rtl_opt_3_reg_5;

wire [22:0]Mx_int_rtl_opt_3_reg_1;
wire [22:0]Mx_int_rtl_opt_3_reg_2;
wire [22:0]Mx_int_rtl_opt_3_reg_3;
wire [22:0]Mx_int_rtl_opt_3_reg_4;
wire [22:0]Mx_int_rtl_opt_3_reg_5;

wire [22:0]My_int_rtl_opt_3_reg_1;
wire [22:0]My_int_rtl_opt_3_reg_2;
wire [22:0]My_int_rtl_opt_3_reg_3;
wire [22:0]My_int_rtl_opt_3_reg_4;
wire [22:0]My_int_rtl_opt_3_reg_5;

wire [7:0]Ex_int_rtl_opt_3_reg_1;
wire [7:0]Ex_int_rtl_opt_3_reg_2;
wire [7:0]Ex_int_rtl_opt_3_reg_3;
wire [7:0]Ex_int_rtl_opt_3_reg_4;
wire [7:0]Ex_int_rtl_opt_3_reg_5;

wire [7:0]Ey_int_rtl_opt_3_reg_1;
wire [7:0]Ey_int_rtl_opt_3_reg_2;
wire [7:0]Ey_int_rtl_opt_3_reg_3;
wire [7:0]Ey_int_rtl_opt_3_reg_4;
wire [7:0]Ey_int_rtl_opt_3_reg_5;

wire [7:0]Out_mux_rtl_opt_3_reg_1;
wire [7:0]Out_mux_rtl_opt_3_reg_2;
wire [7:0]Out_mux_rtl_opt_3_reg_3;
wire [7:0]Out_mux_rtl_opt_3_reg_4;
wire [7:0]Out_mux_rtl_opt_3_reg_5;

wire [4:0]massive_shift_left_rtl_opt_3_reg_1;
wire [4:0]massive_shift_left_rtl_opt_3_reg_2;
wire [4:0]massive_shift_left_rtl_opt_3_reg_3;
wire [4:0]massive_shift_left_rtl_opt_3_reg_4;
wire [4:0]massive_shift_left_rtl_opt_3_reg_5;

wire EOP_rtl_opt_3_reg_1;
wire EOP_rtl_opt_3_reg_2;
wire EOP_rtl_opt_3_reg_3;
wire EOP_rtl_opt_3_reg_4;
wire EOP_rtl_opt_3_reg_5;

wire Sz_int_rtl_opt_3_reg_1;
wire Sz_int_rtl_opt_3_reg_2;
wire Sz_int_rtl_opt_3_reg_3;
wire Sz_int_rtl_opt_3_reg_4;
wire Sz_int_rtl_opt_3_reg_5;
wire Sz_int_rtl_opt_3_reg_6;
wire Sz_int_rtl_opt_3_reg_7;

wire inexact_flag_int_rtl_opt_3_reg_1;
wire inexact_flag_int_rtl_opt_3_reg_2;

wire invalid_flag_int_rtl_opt_3_reg_1;
wire invalid_flag_int_rtl_opt_3_reg_2;

wire min_exponent_z_rtl_opt_3_reg_1;
wire min_exponent_z_rtl_opt_3_reg_2;

wire overflow_flag_int_rtl_opt_3_reg_1;
wire overflow_flag_int_rtl_opt_3_reg_2;

wire underflow_flag_int_rtl_opt_3_reg_1;
wire underflow_flag_int_rtl_opt_3_reg_2;


//assignmens
assign EOP = Sx_int ^ Sy_int ^ sub_int;
assign most_bits_of_adder_out = {ovf , sum[26] , sum[25]};
//instances of RTL optimization regs
bit_1_reg bit_1_reg_EOP_rtl_1 (EOP_opt_2_rtl_3 , clk , rst , EOP_rtl_1);
bit_1_reg bit_1_reg_EOP_rtl_2 (EOP_rtl_1 , clk , rst , EOP_rtl_2);
bit_1_reg bit_1_reg_EOP_rtl_3 (EOP_rtl_2 , clk , rst , EOP_rtl_3);
bit_1_reg bit_1_reg_EOP_rtl_4 (EOP_rtl_3 , clk , rst , EOP_rtl_4);
bit_1_reg bit_1_reg_EOP_rtl_5 (EOP_rtl_4 , clk , rst , EOP_rtl_5);
bit_1_reg bit_1_reg_EOP_rtl_6 (EOP_rtl_5 , clk , rst , EOP_rtl_6);
bit_1_reg bit_1_reg_EOP_rtl_7 (EOP_rtl_6 , clk , rst , EOP_rtl_7);
bit_1_reg bit_1_reg_sgn_d_rtl_1 (sgn_d , clk , rst , sgn_d_rtl_1);
bit_1_reg bit_1_reg_sgn_d_rtl_2 (sgn_d_rtl_1 , clk , rst , sgn_d_rtl_2);
bit_1_reg bit_1_reg_sgn_d_rtl_3 (sgn_d_rtl_2 , clk , rst , sgn_d_rtl_3);
bit_1_reg bit_1_reg_sgn_d_rtl_4 (sgn_d_rtl_3 , clk , rst , sgn_d_rtl_4);
bit_1_reg bit_1_reg_sgn_d_rtl_5 (sgn_d_rtl_4 , clk , rst , sgn_d_rtl_5);
bit_1_reg bit_1_reg_sgn_d_rtl_6 (sgn_d_rtl_5 , clk , rst , sgn_d_rtl_6);
bit_1_reg bit_1_reg_sgn_d_rtl_7 (sgn_d_rtl_6 , clk , rst , sgn_d_rtl_7);
bit_1_reg bit_1_reg_zero_d_rtl_1 (zero_d , clk , rst , zero_d_rtl_1);
bit_1_reg bit_1_reg_zero_d_rtl_2 (zero_d_rtl_1 , clk , rst , zero_d_rtl_2);
bit_1_reg bit_1_reg_zero_d_rtl_3 (zero_d_rtl_2 , clk , rst , zero_d_rtl_3);
bit_1_reg bit_1_reg_zero_d_rtl_4 (zero_d_rtl_3 , clk , rst , zero_d_rtl_4);
bit_1_reg bit_1_reg_zero_d_rtl_5 (zero_d_rtl_4 , clk , rst , zero_d_rtl_5);
bit_1_reg bit_1_reg_zero_d_rtl_6 (zero_d_rtl_5 , clk , rst , zero_d_rtl_6);
bit_1_reg bit_1_reg_zero_d_rtl_7 (zero_d_rtl_6 , clk , rst , zero_d_rtl_7);
bit_1_reg bit_1_reg_Sy_int_rtl_1 (Sy_int_opt_2_rtl_3 , clk , rst , Sy_int_rtl_1);
bit_1_reg bit_1_reg_Sy_int_rtl_2 (Sy_int_rtl_1 , clk , rst , Sy_int_rtl_2);
bit_1_reg bit_1_reg_Sy_int_rtl_3 (Sy_int_rtl_2 , clk , rst , Sy_int_rtl_3);
bit_1_reg bit_1_reg_Sy_int_rtl_4 (Sy_int_rtl_3 , clk , rst , Sy_int_rtl_4);
bit_1_reg bit_1_reg_Sy_int_rtl_5 (Sy_int_rtl_4 , clk , rst , Sy_int_rtl_5);
bit_1_reg bit_1_reg_Sy_int_rtl_6 (Sy_int_rtl_5 , clk , rst , Sy_int_rtl_6);
bit_1_reg bit_1_reg_Sy_int_rtl_7 (Sy_int_rtl_6 , clk , rst , Sy_int_rtl_7);
bit_1_reg bit_1_reg_Sx_int_rtl_1 (Sx_int_opt_2_rtl_3 , clk , rst , Sx_int_rtl_1);
bit_1_reg bit_1_reg_Sx_int_rtl_2 (Sx_int_rtl_1 , clk , rst , Sx_int_rtl_2);
bit_1_reg bit_1_reg_Sx_int_rtl_3 (Sx_int_rtl_2 , clk , rst , Sx_int_rtl_3);
bit_1_reg bit_1_reg_Sx_int_rtl_4 (Sx_int_rtl_3 , clk , rst , Sx_int_rtl_4);
bit_1_reg bit_1_reg_Sx_int_rtl_5 (Sx_int_rtl_4 , clk , rst , Sx_int_rtl_5);
bit_1_reg bit_1_reg_Sx_int_rtl_6 (Sx_int_rtl_5 , clk , rst , Sx_int_rtl_6);
bit_1_reg bit_1_reg_Sx_int_rtl_7 (Sx_int_rtl_6 , clk , rst , Sx_int_rtl_7);
bit_2_reg bit_2_reg_roundMode_int_rtl_1 (roundMode_int_opt_2_rtl_3 , clk , rst , roundMode_int_rtl_1);
bit_2_reg bit_2_reg_roundMode_int_rtl_2 (roundMode_int_rtl_1 , clk , rst , roundMode_int_rtl_2);
bit_2_reg bit_2_reg_roundMode_int_rtl_3 (roundMode_int_rtl_2 , clk , rst , roundMode_int_rtl_3);
bit_2_reg bit_2_reg_roundMode_int_rtl_4 (roundMode_int_rtl_3 , clk , rst , roundMode_int_rtl_4);
bit_2_reg bit_2_reg_roundMode_int_rtl_5 (roundMode_int_rtl_4 , clk , rst , roundMode_int_rtl_5);
bit_2_reg bit_2_reg_roundMode_int_rtl_6 (roundMode_int_rtl_5 , clk , rst , roundMode_int_rtl_6);
bit_2_reg bit_2_reg_roundMode_int_rtl_7 (roundMode_int_rtl_6 , clk , rst , roundMode_int_rtl_7);
bit_23_reg bit_23_reg_Mx_int_rtl_1 (Mx_int_opt_2_rtl_4 , clk , rst , Mx_int_rtl_1);
bit_23_reg bit_23_reg_Mx_int_rtl_2 (Mx_int_rtl_1 , clk , rst , Mx_int_rtl_2);
bit_23_reg bit_23_reg_Mx_int_rtl_3 (Mx_int_rtl_2 , clk , rst , Mx_int_rtl_3);
bit_23_reg bit_23_reg_Mx_int_rtl_4 (Mx_int_rtl_3 , clk , rst , Mx_int_rtl_4);
bit_23_reg bit_23_reg_Mx_int_rtl_5 (Mx_int_rtl_4 , clk , rst , Mx_int_rtl_5);
bit_23_reg bit_23_reg_Mx_int_rtl_6 (Mx_int_rtl_5 , clk , rst , Mx_int_rtl_6);
bit_23_reg bit_23_reg_Mx_int_rtl_7 (Mx_int_rtl_6 , clk , rst , Mx_int_rtl_7);
bit_23_reg bit_23_reg_My_int_rtl_1 (My_int_opt_2_rtl_4 , clk , rst , My_int_rtl_1);
bit_23_reg bit_23_reg_My_int_rtl_2 (My_int_rtl_1 , clk , rst , My_int_rtl_2);
bit_23_reg bit_23_reg_My_int_rtl_3 (My_int_rtl_2 , clk , rst , My_int_rtl_3);
bit_23_reg bit_23_reg_My_int_rtl_4 (My_int_rtl_3 , clk , rst , My_int_rtl_4);
bit_23_reg bit_23_reg_My_int_rtl_5 (My_int_rtl_4 , clk , rst , My_int_rtl_5);
bit_23_reg bit_23_reg_My_int_rtl_6 (My_int_rtl_5 , clk , rst , My_int_rtl_6);
bit_23_reg bit_23_reg_My_int_rtl_7 (My_int_rtl_6 , clk , rst , My_int_rtl_7);
bit_8_reg bit_8_reg_Ey_int_rtl_1 (Ey_int_opt_2_rtl_4 , clk , rst , Ey_int_rtl_1);
bit_8_reg bit_8_reg_Ey_int_rtl_2 (Ey_int_rtl_1 , clk , rst , Ey_int_rtl_2);
bit_8_reg bit_8_reg_Ey_int_rtl_3 (Ey_int_rtl_2 , clk , rst , Ey_int_rtl_3);
bit_8_reg bit_8_reg_Ey_int_rtl_4 (Ey_int_rtl_3 , clk , rst , Ey_int_rtl_4);
bit_8_reg bit_8_reg_Ey_int_rtl_5 (Ey_int_rtl_4 , clk , rst , Ey_int_rtl_5);
bit_8_reg bit_8_reg_Ey_int_rtl_6 (Ey_int_rtl_5 , clk , rst , Ey_int_rtl_6);
bit_8_reg bit_8_reg_Ey_int_rtl_7 (Ey_int_rtl_6 , clk , rst , Ey_int_rtl_7);
bit_8_reg bit_8_reg_Ex_int_rtl_1 (Ex_int_opt_2_rtl_4 , clk , rst , Ex_int_rtl_1);
bit_8_reg bit_8_reg_Ex_int_rtl_2 (Ex_int_rtl_1 , clk , rst , Ex_int_rtl_2);
bit_8_reg bit_8_reg_Ex_int_rtl_3 (Ex_int_rtl_2 , clk , rst , Ex_int_rtl_3);
bit_8_reg bit_8_reg_Ex_int_rtl_4 (Ex_int_rtl_3 , clk , rst , Ex_int_rtl_4);
bit_8_reg bit_8_reg_Ex_int_rtl_5 (Ex_int_rtl_4 , clk , rst , Ex_int_rtl_5);
bit_8_reg bit_8_reg_Ex_int_rtl_6 (Ex_int_rtl_5 , clk , rst , Ex_int_rtl_6);
bit_8_reg bit_8_reg_Ex_int_rtl_7 (Ex_int_rtl_6 , clk , rst , Ex_int_rtl_7);
bit_8_reg bit_8_reg_Out_mux_rtl_1 (Out_mux_rtl_opt_3_reg_5 , clk , rst , Out_mux_rtl_1);
bit_8_reg bit_8_reg_Out_mux_rtl_2 (Out_mux_rtl_1 , clk , rst , Out_mux_rtl_2);
bit_8_reg bit_8_reg_Out_mux_rtl_3 (Out_mux_rtl_2 , clk , rst , Out_mux_rtl_3);
bit_8_reg bit_8_reg_Out_mux_rtl_4 (Out_mux_rtl_3 , clk , rst , Out_mux_rtl_4);
bit_8_reg bit_8_reg_Out_mux_rtl_5 (Out_mux_rtl_4 , clk , rst , Out_mux_rtl_5);
bit_8_reg bit_8_reg_Out_mux_rtl_6 (Out_mux_rtl_5 , clk , rst , Out_mux_rtl_6);
bit_8_reg bit_8_reg_Out_mux_rtl_7 (Out_mux_rtl_6 , clk , rst , Out_mux_rtl_7);
bit_3_reg bit_3_reg_most_bits_of_adder_out_rtl_1 (most_bits_of_adder_out_rtl_opt_3_reg_5 , clk , rst , most_bits_of_adder_out_rtl_1);
bit_3_reg bit_3_reg_most_bits_of_adder_out_rtl_2 (most_bits_of_adder_out_rtl_1 , clk , rst , most_bits_of_adder_out_rtl_2);
bit_3_reg bit_3_reg_most_bits_of_adder_out_rtl_3 (most_bits_of_adder_out_rtl_2 , clk , rst , most_bits_of_adder_out_rtl_3);
bit_3_reg bit_3_reg_most_bits_of_adder_out_rtl_4 (most_bits_of_adder_out_rtl_3 , clk , rst , most_bits_of_adder_out_rtl_4);
bit_1_reg bit_1_reg_one_shift_left_rtl_1 (one_shift_left_rtl_opt_3_reg_5 , clk , rst , one_shift_left_rtl_1);
bit_1_reg bit_1_reg_one_shift_left_rtl_2 (one_shift_left_rtl_1 , clk , rst , one_shift_left_rtl_2);
bit_1_reg bit_1_reg_one_shift_left_rtl_3 (one_shift_left_rtl_2 , clk , rst , one_shift_left_rtl_3);
bit_1_reg bit_1_reg_one_shift_left_rtl_4 (one_shift_left_rtl_3 , clk , rst , one_shift_left_rtl_4);
bit_1_reg bit_1_reg_ovf_rtl_1 (ovf_rtl_opt_3_reg_5 , clk , rst , ovf_rtl_1);
bit_1_reg bit_1_reg_ovf_rtl_2 (ovf_rtl_1 , clk , rst , ovf_rtl_2);
bit_1_reg bit_1_reg_ovf_rtl_3 (ovf_rtl_2 , clk , rst , ovf_rtl_3);
bit_1_reg bit_1_reg_ovf_rtl_4 (ovf_rtl_3 , clk , rst , ovf_rtl_4);
bit_27_reg bit_27_reg_sum_rtl_1 (sum_rtl_opt_3_reg_5 , clk , rst , sum_rtl_1);
bit_27_reg bit_27_reg_sum_rtl_2 (sum_rtl_1 , clk , rst , sum_rtl_2);
bit_27_reg bit_27_reg_sum_rtl_3 (sum_rtl_2 , clk , rst , sum_rtl_3);
bit_27_reg bit_27_reg_sum_rtl_4 (sum_rtl_3 , clk , rst , sum_rtl_4);
bit_24_reg bit_24_reg_MOut_rtl_1 (MOut , clk , rst , MOut_rtl_1);
bit_24_reg bit_24_reg_MOut_rtl_2 (MOut_rtl_1 , clk , rst , MOut_rtl_2);
bit_24_reg bit_24_reg_MOut_rtl_3 (MOut_rtl_2 , clk , rst , MOut_rtl_3);
bit_24_reg bit_24_reg_MOut_rtl_4 (MOut_rtl_3 , clk , rst , MOut_rtl_4);
bit_8_reg bit_8_reg_Out_mux_rtl_8 (Out_mux_rtl_7 , clk , rst , Out_mux_rtl_8);
bit_8_reg bit_8_reg_Out_mux_rtl_9 (Out_mux_rtl_8 , clk , rst , Out_mux_rtl_9);
bit_8_reg bit_8_reg_Out_mux_rtl_10 (Out_mux_rtl_9 , clk , rst , Out_mux_rtl_10);
bit_8_reg bit_8_reg_Out_mux_rtl_11 (Out_mux_rtl_10 , clk , rst , Out_mux_rtl_11);
bit_8_reg bit_8_reg_Ex_int_rtl_8 (Ex_int_rtl_7 , clk , rst , Ex_int_rtl_8);
bit_8_reg bit_8_reg_Ex_int_rtl_9 (Ex_int_rtl_8 , clk , rst , Ex_int_rtl_9);
bit_8_reg bit_8_reg_Ex_int_rtl_10 (Ex_int_rtl_9 , clk , rst , Ex_int_rtl_10);
bit_8_reg bit_8_reg_Ex_int_rtl_11 (Ex_int_rtl_10 , clk , rst , Ex_int_rtl_11);
bit_8_reg bit_8_reg_Ey_int_rtl_8 (Ey_int_rtl_7 , clk , rst , Ey_int_rtl_8);
bit_8_reg bit_8_reg_Ey_int_rtl_9 (Ey_int_rtl_8 , clk , rst , Ey_int_rtl_9);
bit_8_reg bit_8_reg_Ey_int_rtl_10 (Ey_int_rtl_9 , clk , rst , Ey_int_rtl_10);
bit_8_reg bit_8_reg_Ey_int_rtl_11 (Ey_int_rtl_10 , clk , rst , Ey_int_rtl_11);
bit_23_reg bit_23_reg_Mx_int_rtl_8 (Mx_int_rtl_7 , clk , rst , Mx_int_rtl_8);
bit_23_reg bit_23_reg_Mx_int_rtl_9 (Mx_int_rtl_8 , clk , rst , Mx_int_rtl_9);
bit_23_reg bit_23_reg_Mx_int_rtl_10 (Mx_int_rtl_9 , clk , rst , Mx_int_rtl_10);
bit_23_reg bit_23_reg_Mx_int_rtl_11 (Mx_int_rtl_10 , clk , rst , Mx_int_rtl_11);
bit_23_reg bit_23_reg_My_int_rtl_8 (My_int_rtl_7 , clk , rst , My_int_rtl_8);
bit_23_reg bit_23_reg_My_int_rtl_9 (My_int_rtl_8 , clk , rst , My_int_rtl_9);
bit_23_reg bit_23_reg_My_int_rtl_10 (My_int_rtl_9 , clk , rst , My_int_rtl_10);
bit_23_reg bit_23_reg_My_int_rtl_11 (My_int_rtl_10 , clk , rst , My_int_rtl_11);
bit_1_reg bit_1_reg_EOP_rtl_8 (EOP_opt_2_rtl_4 , clk , rst , EOP_rtl_8);
bit_1_reg bit_1_reg_EOP_rtl_9 (EOP_rtl_8 , clk , rst , EOP_rtl_9);
bit_1_reg bit_1_reg_EOP_rtl_10 (EOP_rtl_9 , clk , rst , EOP_rtl_10);
bit_1_reg bit_1_reg_EOP_rtl_11 (EOP_rtl_10 , clk , rst , EOP_rtl_11);
bit_1_reg bit_1_reg_Sz_int_rtl_1 (Sz_int_opt_2_rtl_1 , clk , rst , Sz_int_rtl_1);
bit_1_reg bit_1_reg_Sz_int_rtl_2 (Sz_int_rtl_1 , clk , rst , Sz_int_rtl_2);
bit_1_reg bit_1_reg_Sz_int_rtl_3 (Sz_int_rtl_2 , clk , rst , Sz_int_rtl_3);
bit_1_reg bit_1_reg_Sz_int_rtl_4 (Sz_int_rtl_3 , clk , rst , Sz_int_rtl_4);
bit_1_reg bit_1_reg_inexact_flag_rtl_1 (inexact_flag_int_opt_2_rtl_1 , clk , rst , inexact_flag_int_rtl_1);
bit_1_reg bit_1_reg_inexact_flag_rtl_2 (inexact_flag_int_rtl_1 , clk , rst , inexact_flag_int_rtl_2);
bit_1_reg bit_1_reg_inexact_flag_rtl_3 (inexact_flag_int_rtl_2 , clk , rst , inexact_flag_int_rtl_3);
bit_1_reg bit_1_reg_inexact_flag_rtl_4 (inexact_flag_int_rtl_3 , clk , rst , inexact_flag_int_rtl_4);
bit_1_reg bit_1_reg_ovf_rnd_rtl_1 (ovf_rnd , clk , rst , ovf_rnd_rtl_1);
bit_1_reg bit_1_reg_ovf_rnd_rtl_2 (ovf_rnd_rtl_1 , clk , rst , ovf_rnd_rtl_2);
bit_1_reg bit_1_reg_ovf_rnd_rtl_3 (ovf_rnd_rtl_2 , clk , rst , ovf_rnd_rtl_3);
bit_1_reg bit_1_reg_ovf_rnd_rtl_4 (ovf_rnd_rtl_3 , clk , rst , ovf_rnd_rtl_4);
//instances for rtl_opt_2 registers
bit_23_reg bit_23_reg_Mx_int_opt_2_rtl_1 (Mx_int , clk , rst , Mx_int_opt_2_rtl_1);
bit_23_reg bit_23_reg_Mx_int_opt_2_rtl_2 (Mx_int_opt_2_rtl_1 , clk , rst , Mx_int_opt_2_rtl_2);
bit_23_reg bit_23_reg_Mx_int_opt_2_rtl_3 (Mx_int_opt_2_rtl_2 , clk , rst , Mx_int_opt_2_rtl_3);
bit_23_reg bit_23_reg_Mx_int_opt_2_rtl_4 (Mx_int_rtl_opt_3_reg_5 , clk , rst , Mx_int_opt_2_rtl_4);

bit_23_reg bit_23_reg_My_int_opt_2_rtl_1 (My_int , clk , rst , My_int_opt_2_rtl_1);
bit_23_reg bit_23_reg_My_int_opt_2_rtl_2 (My_int_opt_2_rtl_1 , clk , rst , My_int_opt_2_rtl_2);
bit_23_reg bit_23_reg_My_int_opt_2_rtl_3 (My_int_opt_2_rtl_2 , clk , rst , My_int_opt_2_rtl_3);
bit_23_reg bit_23_reg_My_int_opt_2_rtl_4 (My_int_rtl_opt_3_reg_5 , clk , rst , My_int_opt_2_rtl_4);

bit_8_reg bit_8_reg_Ex_int_opt_2_rtl_1 (Ex_int , clk , rst , Ex_int_opt_2_rtl_1);
bit_8_reg bit_8_reg_Ex_int_opt_2_rtl_2 (Ex_int_opt_2_rtl_1 , clk , rst , Ex_int_opt_2_rtl_2);
bit_8_reg bit_8_reg_Ex_int_opt_2_rtl_3 (Ex_int_opt_2_rtl_2 , clk , rst , Ex_int_opt_2_rtl_3);
bit_8_reg bit_8_reg_Ex_int_opt_2_rtl_4 (Ex_int_rtl_opt_3_reg_5 , clk , rst , Ex_int_opt_2_rtl_4);

bit_8_reg bit_8_reg_Ey_int_opt_2_rtl_1 (Ey_int , clk , rst , Ey_int_opt_2_rtl_1);
bit_8_reg bit_8_reg_Ey_int_opt_2_rtl_2 (Ey_int_opt_2_rtl_1 , clk , rst , Ey_int_opt_2_rtl_2);
bit_8_reg bit_8_reg_Ey_int_opt_2_rtl_3 (Ey_int_opt_2_rtl_2 , clk , rst , Ey_int_opt_2_rtl_3);
bit_8_reg bit_8_reg_Ey_int_opt_2_rtl_4 (Ey_int_rtl_opt_3_reg_5 , clk , rst , Ey_int_opt_2_rtl_4);

bit_1_reg bit_1_reg_Sx_int_opt_2_rtl_1 (Sx_int , clk , rst , Sx_int_opt_2_rtl_1);
bit_1_reg bit_1_reg_Sx_int_opt_2_rtl_2 (Sx_int_opt_2_rtl_1 , clk , rst , Sx_int_opt_2_rtl_2);
bit_1_reg bit_1_reg_Sx_int_opt_2_rtl_3 (Sx_int_opt_2_rtl_2 , clk , rst , Sx_int_opt_2_rtl_3);

bit_1_reg bit_1_reg_Sy_int_opt_2_rtl_1 (Sy_int , clk , rst , Sy_int_opt_2_rtl_1);
bit_1_reg bit_1_reg_Sy_int_opt_2_rtl_2 (Sy_int_opt_2_rtl_1 , clk , rst , Sy_int_opt_2_rtl_2);
bit_1_reg bit_1_reg_Sy_int_opt_2_rtl_3 (Sy_int_opt_2_rtl_2 , clk , rst , Sy_int_opt_2_rtl_3);

bit_1_reg bit_1_reg_EOP_opt_2_rtl_1 (EOP , clk , rst , EOP_opt_2_rtl_1);
bit_1_reg bit_1_reg_EOP_opt_2_rtl_2 (EOP_opt_2_rtl_1 , clk , rst , EOP_opt_2_rtl_2);
bit_1_reg bit_1_reg_EOP_opt_2_rtl_3 (EOP_opt_2_rtl_2 , clk , rst , EOP_opt_2_rtl_3);
bit_1_reg bit_1_reg_EOP_opt_2_rtl_4 (EOP_rtl_opt_3_reg_5 , clk , rst , EOP_opt_2_rtl_4);

bit_2_reg bit_2_reg_roundMode_int_opt_2_rtl_1 (roundMode_int , clk , rst , roundMode_int_opt_2_rtl_1);
bit_2_reg bit_2_reg_roundMode_int_opt_2_rtl_2 (roundMode_int_opt_2_rtl_1 , clk , rst , roundMode_int_opt_2_rtl_2);
bit_2_reg bit_2_reg_roundMode_int_opt_2_rtl_3 (roundMode_int_opt_2_rtl_2 , clk , rst , roundMode_int_opt_2_rtl_3);

bit_24_reg bit_24_reg_mantessa_mux_out_opt_2_rtl_1 (mantessa_mux_out , clk , rst , mantessa_mux_out_opt_2_rtl_1);

bit_1_reg bit_1_reg_Sz_int_opt_2_rtl_1 (Sz_int_rtl_opt_3_reg_7 , clk , rst , Sz_int_opt_2_rtl_1);

bit_1_reg bit_1_reg_inexact_flag_int_opt_2_rtl_1 (inexact_flag_int_rtl_opt_3_reg_2 , clk , rst , inexact_flag_int_opt_2_rtl_1);
//instances of rtl opt 3 regs
bit_3_reg bit_3_reg_most_bits_of_adder_out_rtl_opt_3_reg_1 (most_bits_of_adder_out , clk , rst , most_bits_of_adder_out_rtl_opt_3_reg_1);
bit_3_reg bit_3_reg_most_bits_of_adder_out_rtl_opt_3_reg_2 (most_bits_of_adder_out_rtl_opt_3_reg_1 , clk , rst , most_bits_of_adder_out_rtl_opt_3_reg_2);
bit_3_reg bit_3_reg_most_bits_of_adder_out_rtl_opt_3_reg_3 (most_bits_of_adder_out_rtl_opt_3_reg_2 , clk , rst , most_bits_of_adder_out_rtl_opt_3_reg_3);
bit_3_reg bit_3_reg_most_bits_of_adder_out_rtl_opt_3_reg_4 (most_bits_of_adder_out_rtl_opt_3_reg_3 , clk , rst , most_bits_of_adder_out_rtl_opt_3_reg_4);
bit_3_reg bit_3_reg_most_bits_of_adder_out_rtl_opt_3_reg_5 (most_bits_of_adder_out_rtl_opt_3_reg_4 , clk , rst , most_bits_of_adder_out_rtl_opt_3_reg_5);

bit_24_reg bit_24_reg_correct_sum_shifted_rtl_opt_3_reg_1 (correct_sum_shifted , clk , rst , correct_sum_shifted_rtl_opt_3_reg_1);
bit_24_reg bit_24_reg_correct_sum_shifted_rtl_opt_3_reg_2 (correct_sum_shifted_rtl_opt_3_reg_1 , clk , rst , correct_sum_shifted_rtl_opt_3_reg_2);
bit_24_reg bit_24_reg_correct_sum_shifted_rtl_opt_3_reg_3 (correct_sum_shifted_rtl_opt_3_reg_2 , clk , rst , correct_sum_shifted_rtl_opt_3_reg_3);
bit_24_reg bit_24_reg_correct_sum_shifted_rtl_opt_3_reg_4 (correct_sum_shifted_rtl_opt_3_reg_3 , clk , rst , correct_sum_shifted_rtl_opt_3_reg_4);
bit_24_reg bit_24_reg_correct_sum_shifted_rtl_opt_3_reg_5 (correct_sum_shifted_rtl_opt_3_reg_4 , clk , rst , correct_sum_shifted_rtl_opt_3_reg_5);

bit_1_reg bit_1_reg_one_shift_left_rtl_opt_3_reg_1 (one_shift_left , clk , rst , one_shift_left_rtl_opt_3_reg_1);
bit_1_reg bit_1_reg_one_shift_left_rtl_opt_3_reg_2 (one_shift_left_rtl_opt_3_reg_1 , clk , rst , one_shift_left_rtl_opt_3_reg_2);
bit_1_reg bit_1_reg_one_shift_left_rtl_opt_3_reg_3 (one_shift_left_rtl_opt_3_reg_2 , clk , rst , one_shift_left_rtl_opt_3_reg_3);
bit_1_reg bit_1_reg_one_shift_left_rtl_opt_3_reg_4 (one_shift_left_rtl_opt_3_reg_3 , clk , rst , one_shift_left_rtl_opt_3_reg_4);
bit_1_reg bit_1_reg_one_shift_left_rtl_opt_3_reg_5 (one_shift_left_rtl_opt_3_reg_4 , clk , rst , one_shift_left_rtl_opt_3_reg_5);

bit_1_reg bit_1_reg_ovf_rtl_opt_3_reg_1 (ovf_reg_7 , clk , rst , ovf_rtl_opt_3_reg_1);
bit_1_reg bit_1_reg_ovf_rtl_opt_3_reg_2 (ovf_rtl_opt_3_reg_1 , clk , rst , ovf_rtl_opt_3_reg_2);
bit_1_reg bit_1_reg_ovf_rtl_opt_3_reg_3 (ovf_rtl_opt_3_reg_2 , clk , rst , ovf_rtl_opt_3_reg_3);
bit_1_reg bit_1_reg_ovf_rtl_opt_3_reg_4 (ovf_rtl_opt_3_reg_3 , clk , rst , ovf_rtl_opt_3_reg_4);
bit_1_reg bit_1_reg_ovf_rtl_opt_3_reg_5 (ovf_rtl_opt_3_reg_4 , clk , rst , ovf_rtl_opt_3_reg_5);

bit_27_reg bit_27_reg_sum_rtl_opt_3_reg_1 (sum , clk , rst , sum_rtl_opt_3_reg_1);
bit_27_reg bit_27_reg_sum_rtl_opt_3_reg_2 (sum_rtl_opt_3_reg_1 , clk , rst , sum_rtl_opt_3_reg_2);
bit_27_reg bit_27_reg_sum_rtl_opt_3_reg_3 (sum_rtl_opt_3_reg_2 , clk , rst , sum_rtl_opt_3_reg_3);
bit_27_reg bit_27_reg_sum_rtl_opt_3_reg_4 (sum_rtl_opt_3_reg_3 , clk , rst , sum_rtl_opt_3_reg_4);
bit_27_reg bit_27_reg_sum_rtl_opt_3_reg_5 (sum_rtl_opt_3_reg_4 , clk , rst , sum_rtl_opt_3_reg_5);

bit_23_reg bit_23_reg_Mx_int_rtl_opt_3_reg_1 (Mx_int_opt_2_rtl_3 , clk , rst , Mx_int_rtl_opt_3_reg_1);
bit_23_reg bit_23_reg_Mx_int_rtl_opt_3_reg_2 (Mx_int_rtl_opt_3_reg_1 , clk , rst , Mx_int_rtl_opt_3_reg_2);
bit_23_reg bit_23_reg_Mx_int_rtl_opt_3_reg_3 (Mx_int_rtl_opt_3_reg_2 , clk , rst , Mx_int_rtl_opt_3_reg_3);
bit_23_reg bit_23_reg_Mx_int_rtl_opt_3_reg_4 (Mx_int_rtl_opt_3_reg_3 , clk , rst , Mx_int_rtl_opt_3_reg_4);
bit_23_reg bit_23_reg_Mx_int_rtl_opt_3_reg_5 (Mx_int_rtl_opt_3_reg_4 , clk , rst , Mx_int_rtl_opt_3_reg_5);

bit_23_reg bit_23_reg_My_int_rtl_opt_3_reg_1 (My_int_opt_2_rtl_3 , clk , rst , My_int_rtl_opt_3_reg_1);
bit_23_reg bit_23_reg_My_int_rtl_opt_3_reg_2 (My_int_rtl_opt_3_reg_1 , clk , rst , My_int_rtl_opt_3_reg_2);
bit_23_reg bit_23_reg_My_int_rtl_opt_3_reg_3 (My_int_rtl_opt_3_reg_2 , clk , rst , My_int_rtl_opt_3_reg_3);
bit_23_reg bit_23_reg_My_int_rtl_opt_3_reg_4 (My_int_rtl_opt_3_reg_3 , clk , rst , My_int_rtl_opt_3_reg_4);
bit_23_reg bit_23_reg_My_int_rtl_opt_3_reg_5 (My_int_rtl_opt_3_reg_4 , clk , rst , My_int_rtl_opt_3_reg_5);

bit_8_reg bit_8_reg_Ex_int_rtl_opt_3_reg_1 (Ex_int_opt_2_rtl_3 , clk , rst , Ex_int_rtl_opt_3_reg_1);
bit_8_reg bit_8_reg_Ex_int_rtl_opt_3_reg_2 (Ex_int_rtl_opt_3_reg_1 , clk , rst , Ex_int_rtl_opt_3_reg_2);
bit_8_reg bit_8_reg_Ex_int_rtl_opt_3_reg_3 (Ex_int_rtl_opt_3_reg_2 , clk , rst , Ex_int_rtl_opt_3_reg_3);
bit_8_reg bit_8_reg_Ex_int_rtl_opt_3_reg_4 (Ex_int_rtl_opt_3_reg_3 , clk , rst , Ex_int_rtl_opt_3_reg_4);
bit_8_reg bit_8_reg_Ex_int_rtl_opt_3_reg_5 (Ex_int_rtl_opt_3_reg_4 , clk , rst , Ex_int_rtl_opt_3_reg_5);

bit_8_reg bit_8_reg_Ey_int_rtl_opt_3_reg_1 (Ey_int_opt_2_rtl_3 , clk , rst , Ey_int_rtl_opt_3_reg_1);
bit_8_reg bit_8_reg_Ey_int_rtl_opt_3_reg_2 (Ey_int_rtl_opt_3_reg_1 , clk , rst , Ey_int_rtl_opt_3_reg_2);
bit_8_reg bit_8_reg_Ey_int_rtl_opt_3_reg_3 (Ey_int_rtl_opt_3_reg_2 , clk , rst , Ey_int_rtl_opt_3_reg_3);
bit_8_reg bit_8_reg_Ey_int_rtl_opt_3_reg_4 (Ey_int_rtl_opt_3_reg_3 , clk , rst , Ey_int_rtl_opt_3_reg_4);
bit_8_reg bit_8_reg_Ey_int_rtl_opt_3_reg_5 (Ey_int_rtl_opt_3_reg_4 , clk , rst , Ey_int_rtl_opt_3_reg_5);

bit_8_reg bit_8_reg_Out_mux_rtl_opt_3_reg_1 (Out_mux , clk , rst , Out_mux_rtl_opt_3_reg_1);
bit_8_reg bit_8_reg_Out_mux_rtl_opt_3_reg_2 (Out_mux_rtl_opt_3_reg_1 , clk , rst , Out_mux_rtl_opt_3_reg_2);
bit_8_reg bit_8_reg_Out_mux_rtl_opt_3_reg_3 (Out_mux_rtl_opt_3_reg_2 , clk , rst , Out_mux_rtl_opt_3_reg_3);
bit_8_reg bit_8_reg_Out_mux_rtl_opt_3_reg_4 (Out_mux_rtl_opt_3_reg_3 , clk , rst , Out_mux_rtl_opt_3_reg_4);
bit_8_reg bit_8_reg_Out_mux_rtl_opt_3_reg_5 (Out_mux_rtl_opt_3_reg_4 , clk , rst , Out_mux_rtl_opt_3_reg_5);


bit_5_reg bit_5_reg_massive_shift_left_rtl_opt_3_reg_1 (massive_shift_left , clk , rst , massive_shift_left_rtl_opt_3_reg_1);
bit_5_reg bit_5_reg_massive_shift_left_rtl_opt_3_reg_2 (massive_shift_left_rtl_opt_3_reg_1 , clk , rst , massive_shift_left_rtl_opt_3_reg_2);
bit_5_reg bit_5_reg_massive_shift_left_rtl_opt_3_reg_3 (massive_shift_left_rtl_opt_3_reg_2 , clk , rst , massive_shift_left_rtl_opt_3_reg_3);
bit_5_reg bit_5_reg_massive_shift_left_rtl_opt_3_reg_4 (massive_shift_left_rtl_opt_3_reg_3 , clk , rst , massive_shift_left_rtl_opt_3_reg_4);
bit_5_reg bit_5_reg_massive_shift_left_rtl_opt_3_reg_5 (massive_shift_left_rtl_opt_3_reg_4 , clk , rst , massive_shift_left_rtl_opt_3_reg_5);

bit_1_reg bit_1_reg_EOP_rtl_opt_3_reg_1 (EOP_rtl_7 , clk , rst , EOP_rtl_opt_3_reg_1);
bit_1_reg bit_1_reg_EOP_rtl_opt_3_reg_2 (EOP_rtl_opt_3_reg_1 , clk , rst , EOP_rtl_opt_3_reg_2);
bit_1_reg bit_1_reg_EOP_rtl_opt_3_reg_3 (EOP_rtl_opt_3_reg_2 , clk , rst , EOP_rtl_opt_3_reg_3);
bit_1_reg bit_1_reg_EOP_rtl_opt_3_reg_4 (EOP_rtl_opt_3_reg_3 , clk , rst , EOP_rtl_opt_3_reg_4);
bit_1_reg bit_1_reg_EOP_rtl_opt_3_reg_5 (EOP_rtl_opt_3_reg_4 , clk , rst , EOP_rtl_opt_3_reg_5);

bit_1_reg bit_1_reg_Sz_int_rtl_opt_3_reg_1 (Sz_int , clk , rst , Sz_int_rtl_opt_3_reg_1);
bit_1_reg bit_1_reg_Sz_int_rtl_opt_3_reg_2 (Sz_int_rtl_opt_3_reg_1 , clk , rst , Sz_int_rtl_opt_3_reg_2);
bit_1_reg bit_1_reg_Sz_int_rtl_opt_3_reg_3 (Sz_int_rtl_opt_3_reg_2 , clk , rst , Sz_int_rtl_opt_3_reg_3);
bit_1_reg bit_1_reg_Sz_int_rtl_opt_3_reg_4 (Sz_int_rtl_opt_3_reg_3 , clk , rst , Sz_int_rtl_opt_3_reg_4);
bit_1_reg bit_1_reg_Sz_int_rtl_opt_3_reg_5 (Sz_int_rtl_opt_3_reg_4 , clk , rst , Sz_int_rtl_opt_3_reg_5);
bit_1_reg bit_1_reg_Sz_int_rtl_opt_3_reg_6 (Sz_int_rtl_opt_3_reg_5 , clk , rst , Sz_int_rtl_opt_3_reg_6);
bit_1_reg bit_1_reg_Sz_int_rtl_opt_3_reg_7 (Sz_int_rtl_opt_3_reg_6 , clk , rst , Sz_int_rtl_opt_3_reg_7);

bit_1_reg bit_1_reg_inexact_flag_int_rtl_opt_3_reg_1 (inexact_flag_int , clk , rst , inexact_flag_int_rtl_opt_3_reg_1);
bit_1_reg bit_1_reg_inexact_flag_int_rtl_opt_3_reg_2 (inexact_flag_int_rtl_opt_3_reg_1 , clk , rst , inexact_flag_int_rtl_opt_3_reg_2);

bit_1_reg bit_1_reg_invalid_flag_int_rtl_opt_3_reg_1 (invalid_flag_int , clk , rst , invalid_flag_int_rtl_opt_3_reg_1);
bit_1_reg bit_1_reg_invalid_flag_int_rtl_opt_3_reg_2 (invalid_flag_int_rtl_opt_3_reg_1 , clk , rst , invalid_flag_int_rtl_opt_3_reg_2);

bit_1_reg bit_1_reg_min_exponent_z_rtl_opt_3_reg_1 (min_exponent_z , clk , rst , min_exponent_z_rtl_opt_3_reg_1);
bit_1_reg bit_1_reg_min_exponent_z_rtl_opt_3_reg_2 (min_exponent_z_rtl_opt_3_reg_1 , clk , rst , min_exponent_z_rtl_opt_3_reg_2);

bit_1_reg bit_1_reg_overflow_flag_int_rtl_opt_3_reg_1 (overflow_flag_int , clk , rst , overflow_flag_int_rtl_opt_3_reg_1);
bit_1_reg bit_1_reg_overflow_flag_int_rtl_opt_3_reg_2 (overflow_flag_int_rtl_opt_3_reg_1 , clk , rst , overflow_flag_int_rtl_opt_3_reg_2);

bit_1_reg bit_1_reg_underflow_flag_int_rtl_opt_3_reg_1 (underflow_flag_int , clk , rst , underflow_flag_int_rtl_opt_3_reg_1);
bit_1_reg bit_1_reg_underflow_flag_int_rtl_opt_3_reg_2 (underflow_flag_int_rtl_opt_3_reg_1 , clk , rst , underflow_flag_int_rtl_opt_3_reg_2);

//instances of optimization registerrs
bit_24_reg bit_24_reg_correct_sum_shifted_opt (correct_sum_shifted_rtl_opt_3_reg_5 , clk , rst , correct_sum_shifted_reg);
bit_24_reg bit_24_reg_MOut_opt (MOut_rtl_4 , clk , rst , MOut_reg);
bit_3_reg bit_3_reg_most_bits_of_adder_out_opt (most_bits_of_adder_out_rtl_4 , clk , rst , most_bits_of_adder_out_reg);
//
bit_8_reg bit_8_reg_Out_mux_opt (Out_mux_rtl_11 , clk , rst , Out_mux_reg);
bit_8_reg bit_8_reg_Out_mux_opt_2 (Out_mux_reg , clk , rst , Out_mux_reg_2);
bit_5_reg bit_5_reg_massive_shift_left_opt (massive_shift_left_rtl_opt_3_reg_5 , clk , rst , massive_shift_left_reg);
bit_1_reg bit_1_reg_ovf_rnd_opt (ovf_rnd_rtl_4 , clk , rst , ovf_rnd_reg);
bit_1_reg bit_1_reg_one_shift_left_opt (one_shift_left_rtl_4 , clk , rst , one_shift_left_reg);
bit_1_reg bit_1_reg_ovf_opt (ovf_rtl_4 , clk , rst , ovf_reg);
bit_27_reg bit_27_reg_sum_opt (sum_rtl_4 , clk , rst , sum_reg);
//
bit_8_reg bit_8_reg_Ex_int_opt (Ex_int_rtl_11 , clk , rst , Ex_int_reg);
bit_8_reg bit_8_reg_Ex_int_opt_2 (Ex_int_reg , clk , rst , Ex_int_reg_2);
bit_8_reg bit_8_reg_Ey_int_opt (Ey_int_rtl_11 , clk , rst , Ey_int_reg);
bit_8_reg bit_8_reg_Ey_int_opt_2 (Ey_int_reg , clk , rst , Ey_int_reg_2);
bit_1_reg bit_1_reg_EOP_opt (EOP_rtl_11 , clk , rst , EOP_reg);
bit_1_reg bit_1_reg_EOP_opt_2_exceptions (EOP_reg , clk , rst , EOP_reg_2_exceptions);
bit_23_reg bit_23_reg_Mx_int_opt (Mx_int_rtl_11 , clk , rst , Mx_int_reg);
bit_23_reg bit_23_reg_Mx_int_opt_2 (Mx_int_reg , clk , rst , Mx_int_reg_2);
bit_23_reg bit_23_reg_My_int_opt (My_int_rtl_11 , clk , rst , My_int_reg);
bit_23_reg bit_23_reg_My_int_opt_2 (My_int_reg , clk , rst , My_int_reg_2);
//
bit_27_reg bit_27_reg_out_11_opt (out_11 , clk , rst , out_11_reg);
bit_27_reg bit_27_reg_out_22_opt (out_22 , clk , rst , out_22_reg);
bit_1_reg bit_1_reg_EOP_2_opt (EOP_rtl_7 , clk , rst , EOP_reg_2);
//
bit_1_reg bit_1_reg_Sz_int_2_opt (Sz_int , clk , rst , Sz_int_reg_2);
bit_2_reg bit_2_reg_roundMode_int_2_opt (roundMode_int_rtl_7 , clk , rst , roundMode_int_reg_2);
//
bit_23_reg bit_23_reg_Mx_int_opt_3 (Mx_int_opt_2_rtl_3 , clk , rst , Mx_int_reg_3);
bit_23_reg bit_23_reg_My_int_opt_3 (My_int_opt_2_rtl_3 , clk , rst , My_int_reg_3);
bit_8_reg bit_8_reg_d_opt_3 (d , clk , rst , d_reg_3);
bit_8_reg bit_8_reg_Ex_int_opt_3 (Ex_int_opt_2_rtl_3 , clk , rst , Ex_int_reg_3);
bit_8_reg bit_8_reg_Ey_int_opt_3 (Ey_int_opt_2_rtl_3 , clk , rst , Ey_int_reg_3);
bit_1_reg bit_1_reg_sgn_d_opt_3 (sgn_d , clk , rst , sgn_d_reg_3);
bit_1_reg bit_1_reg_EOP_opt_3 (EOP_opt_2_rtl_3 , clk , rst , EOP_reg_3);
bit_1_reg bit_1_reg_zero_d_opt_3 (zero_d , clk , rst , zero_d_reg_3);
//
bit_1_reg bit_1_reg_EOP_opt_3_adder_modified (EOP_reg_2 , clk , rst , EOP_reg_3_adder_modified);
//
bit_1_reg bit_1_reg_EOP_opt_3_sign_z (EOP_rtl_7 , clk , rst , EOP_reg_3_sign_z);
bit_1_reg bit_1_reg_sgn_d_opt_3_sign_z (sgn_d_rtl_7 , clk , rst , sgn_d_reg_3_sign_z);
bit_1_reg bit_1_reg_zero_d_opt_3_sign_z (zero_d_rtl_7 , clk , rst , zero_d_reg_3_sign_z);
bit_1_reg bit_1_reg_Sx_int_opt_3 (Sx_int_rtl_7 , clk , rst , Sx_int_reg_3);
bit_1_reg bit_1_reg_Sy_int_opt_3 (Sy_int_rtl_7 , clk , rst , Sy_int_reg_3);
//
bit_2_reg bit_2_reg_roundMode_int_opt_3 (roundMode_int_reg_2 , clk , rst , roundMode_int_reg_3);
//
bit_8_reg bit_8_reg_Out_mux_opt_3 (Out_mux_reg_2 , clk , rst , Out_mux_reg_3);
//
bit_8_reg bit_8_reg_Ex_int_opt_3_exceptions (Ex_int_reg_2 , clk , rst , Ex_int_reg_3_exceptions);
bit_8_reg bit_8_reg_Ey_int_opt_3_exceptions (Ey_int_reg_2 , clk , rst , Ey_int_reg_3_exceptions);
bit_1_reg bit_1_reg_EOP_opt_3_exceptions (EOP_reg_2_exceptions , clk , rst , EOP_reg_3_exceptions);
bit_23_reg bit_23_reg_Mx_int_opt_3_exceptions (Mx_int_reg_2 , clk , rst , Mx_int_reg_3_exceptions);
bit_23_reg bit_23_reg_My_int_opt_3_exceptions (My_int_reg_2 , clk , rst , My_int_reg_3_exceptions);
//
bit_27_reg bit_27_reg_sum_opt_4 (sum , clk , rst , sum_reg_4);
bit_27_reg bit_27_reg_out_11_opt_4 (out_11_reg , clk , rst , out_11_reg_4);
bit_27_reg bit_27_reg_out_22_opt_4 (out_22_reg , clk , rst , out_22_reg_4);
//
bit_3_reg bit_3_reg_most_bits_of_adder_out_opt_4 (most_bits_of_adder_out_reg , clk , rst , most_bits_of_adder_out_reg_4);
bit_24_reg bit_24_reg_MOut_opt_4 (MOut_reg , clk , rst , MOut_reg_4);
//
bit_27_reg bit_27_reg_sum_opt_4_Exponent_Update (sum_reg , clk , rst , sum_reg_4_Exponent_Update);
bit_1_reg bit_1_reg_ovf_opt_4 (ovf_reg , clk , rst , ovf_reg_4);
bit_1_reg bit_1_reg_one_shift_left_opt_4 (one_shift_left_reg , clk , rst , one_shift_left_reg_4);
bit_1_reg bit_1_reg_ovf_rnd_opt_4 (ovf_rnd_reg , clk , rst , ovf_rnd_reg_4);
bit_8_reg bit_8_reg_Out_mux_opt_4 (Out_mux_reg_3 , clk , rst , Out_mux_reg_4);
//
bit_8_reg bit_8_reg_Ex_int_opt_4_exceptions (Ex_int_reg_3_exceptions , clk , rst , Ex_int_reg_4_exceptions);
bit_8_reg bit_8_reg_Ey_int_opt_4_exceptions (Ey_int_reg_3_exceptions , clk , rst , Ey_int_reg_4_exceptions);
bit_1_reg bit_1_reg_EOP_opt_4_exceptions (EOP_reg_3_exceptions , clk , rst , EOP_reg_4_exceptions);
bit_23_reg bit_23_reg_Mx_int_opt_4_exceptions (Mx_int_reg_3_exceptions , clk , rst , Mx_int_reg_4_exceptions);
bit_23_reg bit_23_reg_My_int_opt_4_exceptions (My_int_reg_3_exceptions , clk , rst , My_int_reg_4_exceptions);
//
bit_8_reg bit_8_reg_Ex_int_opt_5_exceptions (Ex_int_reg_4_exceptions , clk , rst , Ex_int_reg_5_exceptions);
bit_8_reg bit_8_reg_Ey_int_opt_5_exceptions (Ey_int_reg_4_exceptions , clk , rst , Ey_int_reg_5_exceptions);
bit_1_reg bit_1_reg_EOP_opt_5_exceptions (EOP_reg_4_exceptions , clk , rst , EOP_reg_5_exceptions);
bit_23_reg bit_23_reg_Mx_int_opt_5_exceptions (Mx_int_reg_4_exceptions , clk , rst , Mx_int_reg_5_exceptions);
bit_23_reg bit_23_reg_My_int_opt_5_exceptions (My_int_reg_4_exceptions , clk , rst , My_int_reg_5_exceptions);
bit_1_reg bit_1_reg_max_exponent_z_opt_5 (max_exponent_z , clk , rst , max_exponent_z_reg_5);
//
bit_24_reg bit_24_reg_mantessa_mux_out_opt_5 (mantessa_mux_out_opt_2_rtl_1 , clk , rst , mantessa_mux_out_reg_5);
bit_8_reg bit_8_reg_E_exponent_update_opt_5 (E_exponent_update , clk , rst , E_exponent_update_reg_5);
bit_10_reg bit_10_reg_excessive_shift_left_opt_5 (excessive_shift_left , clk , rst , excessive_shift_left_reg_5);
bit_1_reg bit_1_reg_underflow_flag_int_opt_5 (underflow_flag_int , clk , rst , underflow_flag_int_reg_5);
bit_1_reg bit_1_reg_min_exponent_z_opt_5 (min_exponent_z_rtl_opt_3_reg_2 , clk , rst , min_exponent_z_reg_5);
//
bit_8_reg bit_8_reg_Out_mux_opt_6 (Out_mux_reg_4 , clk , rst , Out_mux_reg_6);
bit_24_reg bit_24_reg_mantessa_mux_out_opt_6 (mantessa_mux_out , clk , rst , mantessa_mux_out_reg_6);
bit_5_reg bit_56_reg_massive_shift_left_opt_6 (massive_shift_left_reg , clk , rst , massive_shift_left_reg_6);
bit_1_reg bit_1_reg_ovf_rnd_opt_6 (ovf_rnd_reg_4 , clk , rst , ovf_rnd_reg_6);
bit_1_reg bit_1_reg_one_shift_left_opt_6 (one_shift_left_reg_4 , clk , rst , one_shift_left_reg_6);
bit_1_reg bit_1_reg_ovf_opt_6 (ovf_reg_4 , clk , rst , ovf_reg_6);
bit_27_reg bit_27_reg_sum_opt_6_Exponent_Update (sum_reg_4_Exponent_Update , clk , rst , sum_reg_6_Exponent_Update);
//
bit_8_reg bit_8_reg_Ex_int_opt_6_exceptions (Ex_int_reg_5_exceptions , clk , rst , Ex_int_reg_6_exceptions);
bit_8_reg bit_8_reg_Ey_int_opt_6_exceptions (Ey_int_reg_5_exceptions , clk , rst , Ey_int_reg_6_exceptions);
bit_1_reg bit_1_reg_EOP_opt_6_exceptions (EOP_reg_5_exceptions , clk , rst , EOP_reg_6_exceptions);
bit_23_reg bit_23_reg_Mx_int_opt_6_exceptions (Mx_int_reg_5_exceptions , clk , rst , Mx_int_reg_6_exceptions);
bit_23_reg bit_23_reg_My_int_opt_6_exceptions (My_int_reg_5_exceptions , clk , rst , My_int_reg_6_exceptions);
//
bit_24_reg bit_24_reg_mantessa_mux_out_opt_6_final_output (mantessa_mux_out_reg_5 , clk , rst , mantessa_mux_out_reg_6_final_output);
//
bit_27_reg bit_27_reg_sum_opt_7 (sum , clk , rst , sum_reg_7);
bit_1_reg bit_1_reg_ovf_opt_7 (ovf , clk , rst , ovf_reg_7);
//
bit_1_reg bit_1_reg_Sz_int_opt_7 (Sz_int_reg_2 , clk , rst , Sz_int_reg_7);
bit_2_reg bit_2_reg_roundMode_int_opt_7 (roundMode_int_reg_3 , clk , rst , roundMode_int_reg_7);
//
bit_24_reg bit_24_reg_correct_sum_shifted_opt_7 (correct_sum_shifted_reg , clk , rst , correct_sum_shifted_reg_7);
bit_3_reg bit_3_reg_most_bits_of_adder_out_opt_7 (most_bits_of_adder_out_reg_4 , clk , rst , most_bits_of_adder_out_reg_7);
//
bit_8_reg bit_8_reg_Out_mux_opt_7 (Out_mux_reg_6 , clk , rst , Out_mux_reg_7);
bit_5_reg bit_5_reg_massive_shift_left_opt_7 (massive_shift_left_reg_6 , clk , rst , massive_shift_left_reg_7);
bit_27_reg bit_27_reg_sum_opt_7_Exponent_Update (sum_reg_6_Exponent_Update , clk , rst , sum_reg_7_Exponent_Update);
//
bit_8_reg bit_8_reg_Ex_int_opt_7_exceptions (Ex_int_reg_6_exceptions , clk , rst , Ex_int_reg_7_exceptions);
bit_8_reg bit_8_reg_Ey_int_opt_7_exceptions (Ey_int_reg_6_exceptions , clk , rst , Ey_int_reg_7_exceptions);
bit_1_reg bit_1_reg_EOP_opt_7_exceptions (EOP_reg_6_exceptions , clk , rst , EOP_reg_7_exceptions);
bit_23_reg bit_23_reg_Mx_int_opt_7_exceptions (Mx_int_reg_6_exceptions , clk , rst , Mx_int_reg_7_exceptions);
bit_23_reg bit_23_reg_My_int_opt_7_exceptions (My_int_reg_6_exceptions , clk , rst , My_int_reg_7_exceptions);
//
bit_1_reg bit_1_reg_Cmp_opt_8 (Cmp , clk , rst , Cmp_reg_8);
bit_1_reg bit_1_reg_EOP_opt_8_sign_z (EOP_reg_3_sign_z , clk , rst , EOP_reg_8_sign_z);
bit_1_reg bit_1_reg_sgn_d_opt_8_sign_z (sgn_d_reg_3_sign_z , clk , rst , sgn_d_reg_8_sign_z);
bit_1_reg bit_1_reg_zero_d_opt_8_sign_z (zero_d_reg_3_sign_z , clk , rst , zero_d_reg_8_sign_z);
bit_1_reg bit_1_reg_Sx_int_opt_8 (Sx_int_reg_3 , clk , rst , Sx_int_reg_8);
bit_1_reg bit_1_reg_Sy_int_opt_8 (Sy_int_reg_3 , clk , rst , Sy_int_reg_8);
//
bit_2_reg bit_2_reg_roundMode_int_opt_8 (roundMode_int_reg_7 , clk , rst , roundMode_int_reg_8);
bit_27_reg bit_27_reg_righpass_shift_out_opt_8 (righPass_shift_out , clk , rst , righPass_shift_out_reg_8);
//
bit_24_reg bit_24_reg_correct_sum_shifted_opt_8 (correct_sum_shifted_reg_7 , clk , rst , correct_sum_shifted_reg_8);
bit_3_reg bit_3_reg_most_bits_of_adder_out_opt_8 (most_bits_of_adder_out_reg_7 , clk , rst , most_bits_of_adder_out_reg_8);
//
bit_27_reg bit_27_reg_sum_opt_8_Exponent_Update (sum_reg_7_Exponent_Update , clk , rst , sum_reg_8_Exponent_Update);
bit_1_reg bit_1_reg_ovf_opt_8 (ovf_reg_6 , clk , rst , ovf_reg_8);
bit_1_reg bit_1_reg_one_shift_left_opt_8 (one_shift_left_reg_6 , clk , rst , one_shift_left_reg_8);
bit_5_reg bit_5_reg_massive_shift_left_opt_8 (massive_shift_left_reg_7 , clk , rst , massive_shift_left_reg_8);
bit_8_reg bit_8_reg_Out_mux_opt_8 (Out_mux_reg_7 , clk , rst , Out_mux_reg_8);
//
bit_8_reg bit_8_reg_Ex_int_opt_8_exceptions (Ex_int_reg_7_exceptions , clk , rst , Ex_int_reg_8_exceptions);
bit_8_reg bit_8_reg_Ey_int_opt_8_exceptions (Ey_int_reg_7_exceptions , clk , rst , Ey_int_reg_8_exceptions);
bit_1_reg bit_1_reg_EOP_opt_8_exceptions (EOP_reg_7_exceptions , clk , rst , EOP_reg_8_exceptions);
bit_23_reg bit_23_reg_Mx_int_opt_8_exceptions (Mx_int_reg_7_exceptions , clk , rst , Mx_int_reg_8_exceptions);
bit_23_reg bit_23_reg_My_int_opt_8_exceptions (My_int_reg_7_exceptions , clk , rst , My_int_reg_8_exceptions);
//
bit_8_reg bit_8_reg_Ex_int_opt_9 (Ex_int_opt_2_rtl_3 , clk , rst , Ex_int_reg_9);
bit_8_reg bit_8_reg_Ey_int_opt_9 (Ey_int_opt_2_rtl_3 , clk , rst , Ey_int_reg_9);
bit_1_reg bit_1_reg_sgn_d_opt_9 (sgn_d , clk , rst , sgn_d_reg_9);
bit_24_reg bit_24_reg_mantessa_mux_out_opt_9 (mantessa_mux_out_reg_6 , clk , rst , mantessa_mux_out_reg_9);
bit_5_reg bit_5_reg_massive_shift_left_opt_9 (massive_shift_left_reg_8 , clk , rst , massive_shift_left_reg_9);
bit_1_reg bit_1_reg_ovf_rnd_opt_9 (ovf_rnd_reg_6 , clk , rst , ovf_rnd_reg_9);
bit_1_reg bit_1_reg_one_shift_left_opt_9 (one_shift_left_reg_8 , clk , rst , one_shift_left_reg_9);
bit_1_reg bit_1_reg_ovf_opt_9 (ovf_reg_8 , clk , rst , ovf_reg_9);
bit_27_reg bit_27_reg_sum_opt_9_Exponent_Update (sum_reg_8_Exponent_Update , clk , rst , sum_reg_9_Exponent_Update);
//
bit_8_reg bit_8_reg_Ex_int_opt_9_exceptions (Ex_int_reg_8_exceptions , clk , rst , Ex_int_reg_9_exceptions);
bit_8_reg bit_8_reg_Ey_int_opt_9_exceptions (Ey_int_reg_8_exceptions , clk , rst , Ey_int_reg_9_exceptions);
bit_1_reg bit_1_reg_EOP_opt_9_exceptions (EOP_reg_8_exceptions , clk , rst , EOP_reg_9_exceptions);
bit_23_reg bit_23_reg_Mx_int_opt_9_exceptions (Mx_int_reg_8_exceptions , clk , rst , Mx_int_reg_9_exceptions);
bit_23_reg bit_23_reg_My_int_opt_9_exceptions (My_int_reg_8_exceptions , clk , rst , My_int_reg_9_exceptions);
//
bit_24_reg bit_24_reg_mantessa_mux_out_opt_9_final_output (mantessa_mux_out_reg_6_final_output , clk , rst , mantessa_mux_out_reg_9_final_output);
//
bit_24_reg bit_24_reg_mantessa_mux_out_opt_10_final_output (mantessa_mux_out_reg_9_final_output , clk , rst , mantessa_mux_out_reg_10_final_output);
bit_8_reg bit_8_reg_E_exponent_update_opt_10 (E_exponent_update_reg_5 , clk , rst , E_exponent_update_reg_10);
bit_1_reg bit_1_reg_invalid_flag_int_opt_10 (invalid_flag_int , clk , rst , invalid_flag_int_reg_10);
bit_1_reg bit_1_reg_overflow_flag_int_opt_10 (overflow_flag_int , clk , rst , overflow_flag_int_reg_10);
bit_10_reg bit_10_reg_excessive_shift_left_opt_10 (excessive_shift_left_reg_5 , clk , rst , excessive_shift_left_reg_10);
bit_1_reg bit_1_reg_underflow_flag_int_opt_10 (underflow_flag_int_reg_5 , clk , rst , underflow_flag_int_reg_10);
//
bit_1_reg bit_1_reg_min_exponent_z_opt_10 (min_exponent_z_reg_5 , clk , rst , min_exponent_z_reg_10);
//
bit_1_reg bit_1_reg_min_exponent_z_opt_11 (min_exponent_z_reg_10 , clk , rst , min_exponent_z_reg_11);
bit_23_reg bit_23_reg_Mz_final_int_opt_11 (Mz_final_int , clk , rst , Mz_final_int_reg_11);
//instances of input registers
bit_8_reg_en bit_8_reg_Ex (Ex , clk , rst , enable , Ex_int);
bit_8_reg_en bit_8_reg_Ey (Ey , clk , rst , enable , Ey_int);
bit_23_reg_en bit_23_reg_Mx (Mx , clk , rst , enable , Mx_int);
bit_23_reg_en bit_23_reg_My (My , clk , rst , enable , My_int);
bit_1_reg_en bit_1_reg_Sx (Sx , clk , rst , enable , Sx_int);
bit_1_reg_en bit_1_reg_Sy (Sy , clk , rst , enable , Sy_int);
//bit_1_reg bit_1_reg_EOP (EOP , clk , rst , EOP_int);
bit_1_reg bit_1_reg_sub (sub , clk , rst , sub_int);
bit_2_reg bit_2_reg_roundMode (roundMode , clk , rst , roundMode_int);
//instances for output registers
bit_8_reg bit_8_reg_Ez (Ez_int , clk , rst , Ez_int_out_reg_11);
bit_8_reg bit_8_reg_Ez_int_out_opt_11 (Ez_int_out_reg_11 , clk , rst , Ez);//optimization
bit_23_reg bit_23_reg_Mz (Mz_final_int , clk , rst , Mz_final_int_out_reg_11);
bit_23_reg bit_23_reg_Mz_final_int_out_opt_11 (Mz_final_int_out_reg_11 , clk , rst , Mz_final);//optimization
bit_1_reg bit_1_reg_sz (Sz_int_rtl_4 , clk , rst , Sz_int_out_reg);
bit_1_reg bit_1_reg_sz_out_opt (Sz_int_out_reg , clk , rst , Sz_int_out_reg_2);
bit_1_reg bit_1_reg_sz_out_opt_2 (Sz_int_out_reg_2 , clk , rst , Sz_int_out_reg_4);
bit_1_reg bit_1_reg_sz_out_opt_4 (Sz_int_out_reg_4 , clk , rst , Sz_int_out_reg_5);
bit_1_reg bit_1_reg_sz_out_opt_5 (Sz_int_out_reg_5 , clk , rst , Sz_int_out_reg_6);
bit_1_reg bit_1_reg_sz_out_opt_6 (Sz_int_out_reg_6 , clk , rst , Sz_int_out_reg_7);
bit_1_reg bit_1_reg_sz_out_opt_7 (Sz_int_out_reg_7 , clk , rst , Sz_int_out_reg_9);
bit_1_reg bit_1_reg_sz_out_opt_9 (Sz_int_out_reg_9 , clk , rst , Sz_int_out_reg_10);
bit_1_reg bit_1_reg_sz_out_opt_10 (Sz_int_out_reg_10 , clk , rst , Sz_int_out_reg_11);
bit_1_reg bit_1_reg_sz_out_opt_11 (Sz_int_out_reg_11 , clk , rst , Sz);//optimization
bit_1_reg bit_1_reg_invalid_flag (invalid_flag_int_rtl_opt_3_reg_2 , clk , rst , invalid_flag_int_out_reg_10);
bit_1_reg bit_1_reg_invalid_flag_int_out_opt_10 (invalid_flag_int_out_reg_10 , clk , rst , invalid_flag_int_out_reg_11);
bit_1_reg bit_1_reg_invalid_flag_int_out_opt_11 (invalid_flag_int_out_reg_11 , clk , rst , invalid_flag);//optimization
bit_1_reg bit_1_reg_overflow_flag (overflow_flag_int_rtl_opt_3_reg_2 , clk , rst , overflow_flag_int_out_reg_10);
bit_1_reg bit_1_reg_overflow_flag_int_out_opt_10 (overflow_flag_int_out_reg_10 , clk , rst , overflow_flag_int_out_reg_11);
bit_1_reg bit_1_reg_overflow_flag_int_out_opt_11 (overflow_flag_int_out_reg_11 , clk , rst , overflow_flag);//optimization
bit_1_reg bit_1_reg_underflow_flag (underflow_flag_int_rtl_opt_3_reg_2 , clk , rst , underflow_flag_int_out_reg_5);
bit_1_reg bit_1_reg_underflow_flag_out_opt_5 (underflow_flag_int_out_reg_5 , clk , rst , underflow_flag_int_out_reg_10);
bit_1_reg bit_1_reg_underflow_flag_out_opt_10 (underflow_flag_int_out_reg_10 , clk , rst , underflow_flag_int_out_reg_11);
bit_1_reg bit_1_reg_underflow_flag_out_opt_11 (underflow_flag_int_out_reg_11 , clk , rst , underflow_flag);//optimization
bit_1_reg bit_1_reg_inexact_flag (inexact_flag_int_rtl_4 , clk , rst , inexact_flag_int_out_reg);
bit_1_reg bit_1_reg_inexact_flag_out_opt (inexact_flag_int_out_reg , clk , rst , inexact_flag_int_out_reg_4);
bit_1_reg bit_1_reg_inexact_flag_out_opt_4 (inexact_flag_int_out_reg_4 , clk , rst , inexact_flag_int_out_reg_5);
bit_1_reg bit_1_reg_inexact_flag_out_opt_5 (inexact_flag_int_out_reg_5 , clk , rst , inexact_flag_int_out_reg_6);
bit_1_reg bit_1_reg_inexact_flag_out_opt_6 (inexact_flag_int_out_reg_6 , clk , rst , inexact_flag_int_out_reg_9);
bit_1_reg bit_1_reg_inexact_flag_out_opt_9 (inexact_flag_int_out_reg_9 , clk , rst , inexact_flag_int_out_reg_10);
bit_1_reg bit_1_reg_inexact_flag_out_opt_10 (inexact_flag_int_out_reg_10 , clk , rst , inexact_flag_int_out_reg_11);
bit_1_reg bit_1_reg_inexact_flag_out_opt_11 (inexact_flag_int_out_reg_11 , clk , rst , inexact_flag);//optimization
bit_1_reg bit_1_reg_zero_flag (zero_flag_int , clk , rst , zero_flag);
//instances for input metastability registers
/*bit_8_reg bit_8_reg_Ex_2 (Ex_int , clk , rst , Ex_int_2);
bit_8_reg bit_8_reg_Ex_3 (Ex_int_2 , clk , rst , Ex_int_3);
bit_8_reg bit_8_reg_Ey_2 (Ey_int , clk , rst , Ey_int_2);
bit_8_reg bit_8_reg_Ey_3 (Ey_int_2 , clk , rst , Ey_int_3);
bit_23_reg bit_23_reg_Mx_2 (Mx_int , clk , rst , Mx_int_2);
bit_23_reg bit_23_reg_Mx_3 (Mx_int_2 , clk , rst , Mx_int_3);
bit_23_reg bit_23_reg_My_2 (My_int , clk , rst , My_int_2);
bit_23_reg bit_23_reg_My_3 (My_int_2 , clk , rst , My_int_3);
bit_1_reg bit_1_reg_Sx_2 (Sx_int , clk , rst , Sx_int_2);
bit_1_reg bit_1_reg_Sx_3 (Sx_int_2 , clk , rst , Sx_int_3);
bit_1_reg bit_1_reg_Sy_2 (Sy_int , clk , rst , Sy_int_2);
bit_1_reg bit_1_reg_Sy_3 (Sy_int_2 , clk , rst , Sy_int_3);
bit_1_reg bit_1_reg_sub_2 (sub_int , clk , rst , sub_int_2);
bit_1_reg bit_1_reg_sub_3 (sub_int_2 , clk , rst , sub_int_3);
bit_2_reg bit_2_reg_roundMode_2 (roundMode_int , clk , rst , roundMode_int_2);
bit_2_reg bit_2_reg_roundMode_3 (roundMode_int_2 , clk , rst , roundMode_int_3);
*/
//instances
Exponent_Difference_new Exponent_Difference_inst_new (Ex_int , Ey_int , clk , rst , d , sgn_d , zero_d);
Mux Mux_inst (Ex_int_reg_9 , Ey_int_reg_9 , sgn_d_reg_9 , Out_mux);
Exponent_Update_new Exponent_Update_inst_new (Out_mux_reg_8 , ovf_reg_9 , ovf_rnd_reg_9 , massive_shift_left_reg_9 , one_shift_left_reg_9 , sum_reg_9_Exponent_Update , EOP_reg_8_sign_z , zero_d_reg_8_sign_z , mantessa_mux_out_reg_9 , E_exponent_update , max_exponent_z , min_exponent_z , excessive_shift_left , underflow_flag_int , clk , rst);///////////////////
Alignment_new Alignment_inst_new (Mx_int_reg_3 , My_int_reg_3 , d_reg_3 , Ex_int_reg_3 , Ey_int_reg_3 , sgn_d_reg_3 , EOP_reg_3 , zero_d_reg_3 , Cmp , out_11 , out_22 , clk , rst);
adder_modified_new adder_modified_inst_new (out_11_reg , out_22_reg , EOP_reg_3_adder_modified , sum , ovf);
LZA_and_massive_SHL LZA_and_massive_SHL_inst (out_11_reg_4 , out_22_reg_4 , sum_reg_4 , massive_shift_left , correct_sum_shifted , clk , rst);
left_right_shifter left_right_shifter_inst (sum_reg_7 , ovf_reg_7 , righPass_shift_out , one_shift_left);
round_new round_inst_new (righPass_shift_out_reg_8 , roundMode_int_reg_8 , Sz_int_reg_7 , MOut , ovf_rnd , inexact_flag_int , clk , rst);
mantessa_mux_new mantessa_mux_inst_new (correct_sum_shifted_reg_8 , MOut_reg_4 , most_bits_of_adder_out_reg_8 , mantessa_mux_out);
Sign_of_z_new Sign_of_z_inst_new (Sx_int_reg_8 , Sy_int_reg_8 , EOP_reg_8_sign_z , Cmp_reg_8 , zero_d_reg_8_sign_z , sgn_d_reg_8_sign_z , Sz_int);
exceptions_new exceptions_inst_new (Ex_int_reg_9_exceptions , Ey_int_reg_9_exceptions , Mx_int_reg_9_exceptions , My_int_reg_9_exceptions , EOP_reg_9_exceptions , max_exponent_z_reg_5 , invalid_flag_int , overflow_flag_int);
final_output_new final_output_inst_new (mantessa_mux_out_reg_10_final_output , E_exponent_update_reg_10 , excessive_shift_left_reg_10 , overflow_flag_int_reg_10 , underflow_flag_int_reg_10 , invalid_flag_int_reg_10 , Mz_final_int , Ez_int , clk , rst);
zero_flag_block_new zero_flag_block_inst_new (Mz_final_int_reg_11 , min_exponent_z_reg_11 , zero_flag_int);
endmodule