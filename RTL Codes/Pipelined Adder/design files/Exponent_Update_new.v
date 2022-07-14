module Exponent_Update_new (mux_out , ovf , ovf_rnd , massive_shift_left , one_shift_left , sum , EOP , zero_d , mantessa_mux_out , E_exponent_update , max_exponent_z , min_exponent_z , excessive_shift_left , underflow_flag , clk , rst);
input [23:0]mantessa_mux_out;
input [7:0]mux_out;
input ovf , ovf_rnd;
input [4:0]massive_shift_left;
input one_shift_left;
input [26:0]sum;
input EOP;
input zero_d;
input clk , rst;
output wire [7:0]E_exponent_update;
output wire max_exponent_z , min_exponent_z;
output wire [9:0]excessive_shift_left;
output wire underflow_flag;
//internal signals
wire [9:0]internal_exponent;
//internal signals for RTL optimization regs
wire [26:0]sum_rtl_exp_upd_1;
wire [23:0]mantessa_mux_out_rtl_exp_upd_1;
wire [9:0]internal_exponent_rtl_exp_upd_1;
//
wire EOP_1;
wire EOP_2;
wire EOP_3;
wire EOP_4;
wire EOP_5;
wire EOP_6;
wire EOP_7;
wire EOP_8;
wire EOP_9;
wire EOP_10;
wire EOP_11;
wire EOP_12;
wire EOP_13;
wire EOP_14;
wire EOP_15;
wire EOP_16;

wire zero_d_1;
wire zero_d_2;
wire zero_d_3;
wire zero_d_4;
wire zero_d_5;
wire zero_d_6;
wire zero_d_7;
wire zero_d_8;
wire zero_d_9;
wire zero_d_10;
wire zero_d_11;
wire zero_d_12;
wire zero_d_13;
wire zero_d_14;
wire zero_d_15;
wire zero_d_16;

//instances for RTL optimization regs
bit_27_reg bit_27_reg_sum_rtl_exp_upd_1 (sum , clk , rst , sum_rtl_exp_upd_1);
bit_24_reg bit_24_reg_mantessa_mux_out_rtl_exp_upd_1 (mantessa_mux_out , clk , rst , mantessa_mux_out_rtl_exp_upd_1);
bit_10_reg bit_10_reg_internal_exponent_rtl_exp_upd_1 (internal_exponent , clk , rst , internal_exponent_rtl_exp_upd_1);
//
bit_1_reg bit_1_reg_EOP_1 (EOP , clk , rst , EOP_1);
bit_1_reg bit_1_reg_EOP_2 (EOP_1 , clk , rst , EOP_2);
bit_1_reg bit_1_reg_EOP_3 (EOP_2 , clk , rst , EOP_3);
bit_1_reg bit_1_reg_EOP_4 (EOP_3 , clk , rst , EOP_4);
bit_1_reg bit_1_reg_EOP_5 (EOP_4 , clk , rst , EOP_5);
bit_1_reg bit_1_reg_EOP_6 (EOP_5 , clk , rst , EOP_6);
bit_1_reg bit_1_reg_EOP_7 (EOP_6 , clk , rst , EOP_7);
bit_1_reg bit_1_reg_EOP_8 (EOP_7 , clk , rst , EOP_8);
bit_1_reg bit_1_reg_EOP_9 (EOP_8 , clk , rst , EOP_9);
bit_1_reg bit_1_reg_EOP_10 (EOP_9 , clk , rst , EOP_10);
bit_1_reg bit_1_reg_EOP_11 (EOP_10 , clk , rst , EOP_11);
bit_1_reg bit_1_reg_EOP_12 (EOP_11 , clk , rst , EOP_12);
bit_1_reg bit_1_reg_EOP_13 (EOP_12 , clk , rst , EOP_13);
bit_1_reg bit_1_reg_EOP_14 (EOP_13 , clk , rst , EOP_14);
bit_1_reg bit_1_reg_EOP_15 (EOP_14 , clk , rst , EOP_15);
bit_1_reg bit_1_reg_EOP_16 (EOP_15 , clk , rst , EOP_16);

bit_1_reg bit_1_reg_zero_d_1 (zero_d , clk , rst , zero_d_1);
bit_1_reg bit_1_reg_zero_d_2 (zero_d_1 , clk , rst , zero_d_2);
bit_1_reg bit_1_reg_zero_d_3 (zero_d_2 , clk , rst , zero_d_3);
bit_1_reg bit_1_reg_zero_d_4 (zero_d_3 , clk , rst , zero_d_4);
bit_1_reg bit_1_reg_zero_d_5 (zero_d_4 , clk , rst , zero_d_5);
bit_1_reg bit_1_reg_zero_d_6 (zero_d_5 , clk , rst , zero_d_6);
bit_1_reg bit_1_reg_zero_d_7 (zero_d_6 , clk , rst , zero_d_7);
bit_1_reg bit_1_reg_zero_d_8 (zero_d_7 , clk , rst , zero_d_8);
bit_1_reg bit_1_reg_zero_d_9 (zero_d_8 , clk , rst , zero_d_9);
bit_1_reg bit_1_reg_zero_d_10 (zero_d_9 , clk , rst , zero_d_10);
bit_1_reg bit_1_reg_zero_d_11 (zero_d_10 , clk , rst , zero_d_11);
bit_1_reg bit_1_reg_zero_d_12 (zero_d_11 , clk , rst , zero_d_12);
bit_1_reg bit_1_reg_zero_d_13 (zero_d_12 , clk , rst , zero_d_13);
bit_1_reg bit_1_reg_zero_d_14 (zero_d_13 , clk , rst , zero_d_14);
bit_1_reg bit_1_reg_zero_d_15 (zero_d_14 , clk , rst , zero_d_15);
bit_1_reg bit_1_reg_zero_d_16 (zero_d_15 , clk , rst , zero_d_16);


//instances
Exponent_Update_1 Exponent_Update_1_inst (ovf , ovf_rnd , one_shift_left , sum , mux_out , massive_shift_left , internal_exponent);
Exponent_Update_2 Exponent_Update_2_inst (internal_exponent_rtl_exp_upd_1 , mantessa_mux_out_rtl_exp_upd_1 , sum_rtl_exp_upd_1 , EOP_16 , zero_d_16 , E_exponent_update , max_exponent_z , min_exponent_z , excessive_shift_left , underflow_flag);
endmodule