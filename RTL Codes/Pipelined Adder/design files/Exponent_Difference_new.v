module Exponent_Difference_new (
input wire [7:0] Ex, 
input wire [7:0] Ey,
input wire clk,
input wire rst,
output wire [7:0]  d_rtl_exp_diff_1,
output wire sgn_d,zero_d
);
//internal signals
wire zero_Ex , zero_Ey , carry;
wire [7:0]difference;
//internal signals for RTL optimization registers
wire [7:0]Ex_rtl_exp_diff_1;
wire [7:0]Ey_rtl_exp_diff_1;
wire zero_Ex_rtl_exp_diff_1;
wire zero_Ey_rtl_exp_diff_1;
wire carry_rtl_exp_diff_1;
wire carry_rtl_exp_diff_2;
wire [7:0]difference_rtl_exp_diff_1;
wire [7:0]d;

//instances for RTL optimization regs
bit_8_reg bit_8_reg_Ex_rtl_exp_diff_1 (Ex , clk , rst , Ex_rtl_exp_diff_1);
bit_8_reg bit_8_reg_Ey_rtl_exp_diff_1 (Ey , clk , rst , Ey_rtl_exp_diff_1);
bit_1_reg bit_1_reg_zero_Ex_rtl_exp_diff_1 (zero_Ex , clk , rst , zero_Ex_rtl_exp_diff_1);
bit_1_reg bit_1_reg_zero_Ey_rtl_exp_diff_1 (zero_Ey , clk , rst , zero_Ey_rtl_exp_diff_1);
bit_1_reg bit_1_reg_carry_rtl_exp_diff_1 (carry , clk , rst , carry_rtl_exp_diff_1);
bit_1_reg bit_1_reg_carry_rtl_exp_diff_2 (carry_rtl_exp_diff_1 , clk , rst , carry_rtl_exp_diff_2);
bit_8_reg bit_8_reg_difference_rtl_exp_diff_1 (difference , clk , rst , difference_rtl_exp_diff_1);
bit_8_reg bit_8_reg_d_rtl_exp_diff_1 (d , clk , rst , d_rtl_exp_diff_1);
//instances
Exponent_Difference_1 Exponent_Difference_1_inst (Ex , Ey , zero_Ex , zero_Ey);
Exponent_Difference_2 Exponent_Difference_2_inst (zero_Ex_rtl_exp_diff_1 , zero_Ey_rtl_exp_diff_1 , Ex_rtl_exp_diff_1 , Ey_rtl_exp_diff_1 , carry , difference);
Exponent_Difference_3 Exponent_Difference_3_inst (carry_rtl_exp_diff_1 , difference_rtl_exp_diff_1 , d);
Exponent_Difference_4 Exponent_Difference_4_inst (d_rtl_exp_diff_1 , carry_rtl_exp_diff_2 , zero_d , sgn_d);
endmodule