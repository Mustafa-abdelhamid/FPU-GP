module top_part_three (Sign_in , roundMode , A , B , sub , E_out , ovf , ovf_rnd , final_shift_left , rightpath_exponent_update_control , overFlow , inexact_flag , final_M_out , final_E_out);
input Sign_in;
input [1:0]roundMode;
input [26:0]A , B;
input sub;
input [7:0]E_out;
output  ovf , ovf_rnd;
output  [4:0]final_shift_left;
output  [1:0]rightpath_exponent_update_control;
output  overFlow , inexact_flag;
output  [22:0] final_M_out;
output  [7:0] final_E_out; 
//internal signals
wire [26:0]sum;
wire [26:0]E;
wire [4:0]SHL;
wire [26:0]sum_shifted;
wire [22:0]correct_sum_shifted;
wire second_shift_left;
wire [26:0]righPass_shift_out;
wire [22:0]MOut;
wire [2:0]most_bits_of_adder_out;
assign most_bits_of_adder_out = {ovf , sum[26:25]};
wire underflow_flag , invalid_flag;
wire [22:0]Mz;
//instances
adder_modified adder_mod_inst (A , B , sub , sum , ovf);
LZA_1_modified LZA_1_modified_inst (A , B , E);
LZA_2_modified LZA_2_modified_inst (E,SHL);
first_massive_shift_left first_massive_shift_left_inst (sum , SHL , sum_shifted);
LZA_final_modified LZA_final_modified_inst (sum_shifted , correct_sum_shifted , second_shift_left);
shift_left_adder shift_left_adder_inst (SHL , second_shift_left , final_shift_left);
left_right_shifter left_right_shifter_inst (sum , ovf , righPass_shift_out , rightpath_exponent_update_control);
ROUND ROUND_inst (righPass_shift_out , roundMode , Sign_in , MOut , overFlow , inexact_flag);
mantessa_mux mantessa_mux_inst (correct_sum_shifted , MOut , most_bits_of_adder_out , Mz);
final_output final_output_inst (Mz , E_out , final_shift_left , overFlow , underflow_flag , invalid_flag , final_M_out , final_E_out);
endmodule
