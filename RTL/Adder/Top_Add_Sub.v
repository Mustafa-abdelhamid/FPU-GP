module Top_Add_Sub (
//inputs and outputs
input     wire   [7:0]        Ex,Ey,
input     wire   [22:0]       Mx,My,
input     wire                Sx,Sy,EOP,sub,
input	  wire	 [1:0] 		  roundMode ,////
input     wire                rst , clk, 
output    wire   [7:0]        Ez,
output    wire   [22:0]       Mz_final,
output    wire                Sz,
output	  wire  invalid_flag,overflow_flag,underflow_flag,inexact_flag,zero_flag ////////
); 
//internal signals for input and output registers
wire [7:0]Ex_int,Ey_int;
wire [22:0]Mx_int,My_int;
wire Sx_int,Sy_int,EOP_int,sub_int;
wire [1:0]roundMode_int; ////
wire [7:0]Ez_int;
wire [22:0]Mz_final_int;
wire Sz_int;
wire invalid_flag_int ,overflow_flag_int , underflow_flag_int , inexact_flag_int , zero_flag_int;
//internal signals
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
wire [55:0]correct_sum_shifted;
wire [26:0]righPass_shift_out;
//wire one_shift_left;
wire [22:0]MOut;
wire [2:0]most_bits_of_adder_out;
wire [55:0]mantessa_mux_out;
//assignmens
assign most_bits_of_adder_out = {ovf , sum[26] , sum[25]};
//instances of input registers
bit_8_reg bit_8_reg_Ex (Ex , clk , rst , Ex_int);
bit_8_reg bit_8_reg_Ey (Ey , clk , rst , Ey_int);
bit_23_reg bit_23_reg_Mx (Mx , clk , rst , Mx_int);
bit_23_reg bit_23_reg_My (My , clk , rst , My_int);
bit_1_reg bit_1_reg_Sx (Sx , clk , rst , Sx_int);
bit_1_reg bit_1_reg_Sy (Sy , clk , rst , Sy_int);
bit_1_reg bit_1_reg_EOP (EOP , clk , rst , EOP_int);
bit_1_reg bit_1_reg_sub (sub , clk , rst , sub_int);
bit_2_reg bit_2_reg_roundMode (roundMode , clk , rst , roundMode_int);
//instances for output registers
bit_8_reg bit_8_reg_Ez (Ez_int , clk , rst , Ez);
bit_23_reg bit_23_reg_Mz (Mz_final_int , clk , rst , Mz_final);
bit_1_reg bit_1_reg_Sz (Sz_int , clk , rst , Sz);
bit_1_reg bit_1_reg_invalid_flag (invalid_flag_int , clk , rst , invalid_flag);
bit_1_reg bit_1_reg_overflow_flag (overflow_flag_int , clk , rst , overflow_flag);
bit_1_reg bit_1_reg_underflow_flag (underflow_flag_int , clk , rst , underflow_flag);
bit_1_reg bit_1_reg_inexact_flag (inexact_flag_int , clk , rst , inexact_flag);
bit_1_reg bit_1_reg_zero_flag (zero_flag_int , clk , rst , zero_flag);
//instances
Exponent_Difference Exponent_Difference_inst (Ex_int , Ey_int , d , sgn_d , zero_d);
Mux Mux_inst (Ex_int , Ey_int , sgn_d , Out_mux);
Exponent_Update Exponent_Update_inst (Out_mux , ovf , ovf_rnd , massive_shift_left , one_shift_left , sum , E_exponent_update , max_exponent_z , min_exponent_z , excessive_shift_left , underflow_flag_int);///////////////////
Alignment Alignment_inst (Mx_int , My_int , d , Ex_int , Ey_int , sgn_d , EOP_int , zero_d , Cmp , out_11 , out_22);
adder_modified adder_modified_inst (out_11 , out_22 , sub_int , sum , ovf);
LZA_and_massive_SHL LZA_and_massive_SHL_inst (out_11 , out_22 , sum , massive_shift_left , correct_sum_shifted);
left_right_shifter left_right_shifter_inst (sum , ovf , righPass_shift_out , one_shift_left);
ROUND ROUND_inst (righPass_shift_out , roundMode_int , Sz_int , MOut , ovf_rnd , inexact_flag_int);
mantessa_mux mantessa_mux_inst (correct_sum_shifted , MOut , most_bits_of_adder_out , mantessa_mux_out);
Sign_of_z Sign_of_z_inst (Sx_int , Sy_int , EOP_int , Cmp , zero_d , sgn_d , Sz_int);
exceptions exceptions_inst (Ex_int , Ey_int , Mx_int , My_int , EOP_int , max_exponent_z , invalid_flag_int , overflow_flag_int);
final_output final_output_inst (mantessa_mux_out , E_exponent_update , excessive_shift_left , overflow_flag_int , underflow_flag_int , invalid_flag_int , Mz_final_int , Ez_int);
zero_flag_block zero_flag_block_inst (Mz_final_int , Ez_int , min_exponent_z , zero_flag_int);
endmodule