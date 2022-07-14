module Exponent_Update_new (mux_out , ovf , ovf_rnd , massive_shift_left , one_shift_left , sum , mantessa_mux_out , E_exponent_update , max_exponent_z , min_exponent_z , excessive_shift_left , underflow_flag , clk , rst);
input [23:0]mantessa_mux_out;
input [7:0]mux_out;
input ovf , ovf_rnd;
input [4:0]massive_shift_left;
input one_shift_left;
input [26:0]sum;
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
//instances for RTL optimization regs
bit_27_reg bit_27_reg_sum_rtl_exp_upd_1 (sum , clk , rst , sum_rtl_exp_upd_1);
bit_24_reg bit_24_reg_mantessa_mux_out_rtl_exp_upd_1 (mantessa_mux_out , clk , rst , mantessa_mux_out_rtl_exp_upd_1);
bit_10_reg bit_10_reg_internal_exponent_rtl_exp_upd_1 (internal_exponent , clk , rst , internal_exponent_rtl_exp_upd_1);
//instances
Exponent_Update_1 Exponent_Update_1_inst (ovf , ovf_rnd , one_shift_left , sum , mux_out , massive_shift_left , internal_exponent);
Exponent_Update_2 Exponent_Update_2_inst (internal_exponent_rtl_exp_upd_1 , mantessa_mux_out_rtl_exp_upd_1 , sum_rtl_exp_upd_1 , E_exponent_update , max_exponent_z , min_exponent_z , excessive_shift_left , underflow_flag);
endmodule