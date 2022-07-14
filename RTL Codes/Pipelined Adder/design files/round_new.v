module round_new (
    input	wire 	[26:0] Min   ,  //operands significand in + 3 guard bits
input	wire	[1:0] roundMode,
		
input		Sign_in ,
output	wire		[23:0] MOut  , //24 bits
output	wire				ovf_rnd,inexact_flag_reg_5,
input clk,
input rst
);
//internal signals
wire LSB;
wire [2:0] guard_bits ;
wire hidden_0;
wire [22:0]internal_mantessa_0;
wire hidden_1;
wire [22:0]internal_mantessa_1;
wire hidden_2;
wire [22:0]internal_mantessa_2;
wire hidden_3;
wire [22:0]internal_mantessa_3;
wire hidden_4;
wire [22:0]internal_mantessa_4;
wire hidden_5;
wire [22:0]internal_mantessa_5; 
wire [23:0]MOut_0;
wire [23:0]MOut_1;
wire [23:0]MOut_2;
wire [23:0]MOut_3;
wire [23:0]MOut_4;
wire [23:0]MOut_5;
wire [23:0]MOut_6;
wire [23:0]MOut_7;
wire [23:0]MOut_8;
wire [23:0]MOut_9;
wire [23:0]MOut_10;
wire [23:0]MOut_11;
wire [23:0]MOut_12;
wire [23:0]MOut_13;
wire [23:0]MOut_14;
wire [23:0]MOut_15;
wire [23:0]MOut_16;
wire [23:0]MOut_17;
wire [23:0]MOut_18;
wire [23:0]MOut_19;
wire [23:0]MOut_20;
wire [23:0]MOut_21;
wire [23:0]MOut_22;
wire [23:0]MOut_23;
wire [23:0]MOut_24;
wire [23:0]MOut_25;
wire [23:0]MOut_26;
wire [23:0]MOut_27;
wire [23:0]MOut_28;
wire [23:0]MOut_29;
wire [23:0]MOut_30;
wire [23:0]MOut_31;
wire [23:0]MOut_32;
wire [23:0]MOut_33;
wire ovf_rnd_0;
wire ovf_rnd_1;
wire ovf_rnd_2;
wire ovf_rnd_3;
wire ovf_rnd_4;
wire ovf_rnd_5;
wire ovf_rnd_6;
wire ovf_rnd_7;
wire ovf_rnd_8;
wire ovf_rnd_9;
wire ovf_rnd_10;
wire ovf_rnd_11;
wire zero_signal_1_bit;
wire one_signal_1_bit;
//internal signals for RTL optimization regs
//mux_4_in_2_out
wire ovf_rnd_7_reg_1;

wire [23:0]MOut_21_reg_1;
wire [23:0]MOut_17_reg_1;
wire [23:0]MOut_17_reg_2;
wire [23:0]MOut_17_reg_3;
wire [23:0]MOut_17_reg_4;
wire [23:0]MOut_17_reg_5;

wire [23:0]MOut_22_reg_1;
wire ovf_rnd_8_reg_1;
wire [23:0]MOut_29_reg_1;
wire ovf_rnd_11_reg_1;
wire [1:0]roundMode_reg_1;
wire [1:0]roundMode_reg_2;
wire [1:0]roundMode_reg_3;
wire [1:0]roundMode_reg_4;
wire [1:0]roundMode_reg_5;
//mux_8_in_2_out
wire [23:0]MOut_0_reg_1;
wire [23:0]MOut_0_reg_2;
wire [23:0]MOut_0_reg_3;
wire [23:0]MOut_0_reg_4;

wire [23:0]MOut_1_reg_1;
wire [23:0]MOut_1_reg_2;
wire [23:0]MOut_1_reg_3;
wire [23:0]MOut_1_reg_4;

wire [23:0]MOut_2_reg_1;
wire [23:0]MOut_2_reg_2;
wire [23:0]MOut_2_reg_3;
wire [23:0]MOut_2_reg_4;

wire [23:0]MOut_3_reg_1;
wire [23:0]MOut_3_reg_2;
wire [23:0]MOut_3_reg_3;
wire [23:0]MOut_3_reg_4;

wire [23:0]MOut_7_reg_1;
wire ovf_rnd_1_reg_1;

wire [23:0]MOut_33_reg_2;
wire [23:0]MOut_33_reg_1;
wire ovf_rnd_2_sec_reg_1;
wire ovf_rnd_2_sec_reg_2;
wire ovf_rnd_2_sec_reg_3;
wire ovf_rnd_2_sec_reg_4;

wire [23:0]MOut_13_reg_2;
wire [23:0]MOut_13_reg_1;

wire ovf_rnd_3_sec_reg_1;
wire ovf_rnd_3_sec_reg_2;
wire ovf_rnd_3_sec_reg_3;
wire ovf_rnd_3_sec_reg_4;

wire [23:0]MOut_16_reg_2;
wire [23:0]MOut_16_reg_1;

wire ovf_rnd_4_sec_reg_1;
wire ovf_rnd_4_sec_reg_2;
wire ovf_rnd_4_sec_reg_3;
wire ovf_rnd_4_sec_reg_4;

wire [2:0]guard_bits_reg_1;
wire [2:0]guard_bits_reg_2;
wire [2:0]guard_bits_reg_3;
wire [2:0]guard_bits_reg_4;
//mux_2_in_2_out_25_bits_inst_2
wire [23:0]MOut_20_reg_1;
wire ovf_rnd_6_reg_1;

wire [23:0]MOut_23_reg_1;
wire [23:0]MOut_23_reg_2;
wire [23:0]MOut_23_reg_3;
wire [23:0]MOut_23_reg_4;

wire sign_in_reg_1;
wire sign_in_reg_2;
wire sign_in_reg_3;
wire sign_in_reg_4;
//mux_2_in_2_out_25_bits_inst_3
wire [23:0]MOut_28_reg_1;
wire ovf_rnd_10_reg_1;

wire [23:0]MOut_32_reg_1;
wire [23:0]MOut_32_reg_2;
wire [23:0]MOut_32_reg_3;
wire [23:0]MOut_32_reg_4;

wire inexact_flag_reg_1;
wire inexact_flag_reg_2;
wire inexact_flag_reg_3;
wire inexact_flag_reg_4;
wire inexact_flag;
//mux_2_in_2_out_25_bits_inst_1
wire [23:0]MOut_6_reg_1;
wire [23:0]MOut_6_reg_2;
wire [23:0]MOut_6_reg_3;

wire [23:0]MOut_10_reg_1;

wire ovf_rnd_0_sec_reg_1;
wire ovf_rnd_0_sec_reg_2;
wire ovf_rnd_0_sec_reg_3;

wire LSB_reg_1;
wire LSB_reg_2;
wire LSB_reg_3;
//mux_2_in_1_out_24_bits_inst_1
wire ovf_rnd_0_reg_1;
wire ovf_rnd_0_reg_2;

wire [23:0]MOut_5_reg_1;
wire [23:0]MOut_4_reg_1;
//round_5_inst_1
wire hidden_0_reg_1;
wire [22:0]internal_mantessa_0_reg_1;
//mux_2_in_1_out_24_bits_inst_2
wire ovf_rnd_2_reg_1;
wire ovf_rnd_2_reg_2;

wire [23:0]MOut_8_reg_1;
wire [23:0]MOut_9_reg_1;
//round_5_inst_2
wire hidden_1_reg_1;
wire [22:0]internal_mantessa_1_reg_1;
//mux_2_in_1_out_24_bits_inst_3
wire ovf_rnd_3_reg_1;
wire ovf_rnd_3_reg_2;

wire [23:0]MOut_11_reg_1;
wire [23:0]MOut_12_reg_1;
//round_5_inst_3
wire hidden_2_reg_1;
wire [22:0]internal_mantessa_2_reg_1;
//mux_2_in_1_out_24_bits_inst_4
wire ovf_rnd_4_reg_1;
wire ovf_rnd_4_reg_2;

wire [23:0]MOut_14_reg_1;
wire [23:0]MOut_15_reg_1;
//round_5_inst_4
wire hidden_3_reg_1;
wire [22:0]internal_mantessa_3_reg_1;
//mux_2_in_2_out_3_bits_sel_inst_1
wire [23:0]MOut_19_reg_1;
wire [23:0]MOut_19_reg_2;
wire [23:0]MOut_19_reg_3;

wire ovf_rnd_5_sec_reg_1;
wire ovf_rnd_5_sec_reg_2;
wire ovf_rnd_5_sec_reg_3;

wire [23:0]MOut_18_reg_1;
//mux_2_in_1_out_24_bits_inst_5
wire ovf_rnd_5_reg_1;
wire ovf_rnd_5_reg_2;

wire [23:0]MOut_30_reg_1;
wire [23:0]MOut_31_reg_1;
//round_5_inst_5
wire hidden_4_reg_1;
wire [22:0]internal_mantessa_4_reg_1;
//mux_2_in_2_out_3_bits_sel_inst_2
wire [23:0]MOut_24_reg_1;
wire [23:0]MOut_24_reg_2;
wire [23:0]MOut_24_reg_3;

wire [23:0]MOut_27_reg_1;

wire ovf_rnd_9_sec_reg_1;
wire ovf_rnd_9_sec_reg_2;
wire ovf_rnd_9_sec_reg_3;
//mux_2_in_1_out_24_bits_inst_6
wire ovf_rnd_9_reg_1;
wire ovf_rnd_9_reg_2;

wire [23:0]MOut_25_reg_1;
wire [23:0]MOut_26_reg_1;
//round_5_inst_6
wire hidden_5_reg_1;
wire [22:0]internal_mantessa_5_reg_1;
//assignments
assign LSB = Min[3];
assign guard_bits=Min[2:0];
assign zero_signal_1_bit = 0;
assign one_signal_1_bit = 1;
//instances for RTL optimization regs
//mux_4_in_2_out
bit_1_reg bit_1_reg_ovf_rnd_7_reg_1 (ovf_rnd_7 , clk , rst , ovf_rnd_7_reg_1);
bit_24_reg bit_24_reg_MOut_21_reg_1 (MOut_21 , clk , rst , MOut_21_reg_1);
bit_24_reg bit_24_reg_MOut_17_reg_1 (MOut_17 , clk , rst , MOut_17_reg_1);
bit_24_reg bit_24_reg_MOut_17_reg_2 (MOut_17_reg_1 , clk , rst , MOut_17_reg_2);
bit_24_reg bit_24_reg_MOut_17_reg_3 (MOut_17_reg_2 , clk , rst , MOut_17_reg_3);
bit_24_reg bit_24_reg_MOut_17_reg_4 (MOut_17_reg_3 , clk , rst , MOut_17_reg_4);
bit_24_reg bit_24_reg_MOut_17_reg_5 (MOut_17_reg_4 , clk , rst , MOut_17_reg_5);
bit_24_reg bit_24_reg_MOut_22_reg_1 (MOut_22 , clk , rst , MOut_22_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_8_reg_1 (ovf_rnd_8 , clk , rst , ovf_rnd_8_reg_1);
bit_24_reg bit_24_reg_MOut_29_reg_1 (MOut_29 , clk , rst , MOut_29_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_11_reg_1 (ovf_rnd_11 , clk , rst , ovf_rnd_11_reg_1);
bit_2_reg bit_2_reg_roundMode_reg_1 (roundMode , clk , rst , roundMode_reg_1);
bit_2_reg bit_2_reg_roundMode_reg_2 (roundMode_reg_1 , clk , rst , roundMode_reg_2);
bit_2_reg bit_2_reg_roundMode_reg_3 (roundMode_reg_2 , clk , rst , roundMode_reg_3);
bit_2_reg bit_2_reg_roundMode_reg_4 (roundMode_reg_3 , clk , rst , roundMode_reg_4);
bit_2_reg bit_2_reg_roundMode_reg_5 (roundMode_reg_4 , clk , rst , roundMode_reg_5);
//mux_8_in_2_out
bit_24_reg bit_24_reg_MOut_0_reg_1 (MOut_0 , clk , rst , MOut_0_reg_1);
bit_24_reg bit_24_reg_MOut_0_reg_2 (MOut_0_reg_1 , clk , rst , MOut_0_reg_2);
bit_24_reg bit_24_reg_MOut_0_reg_3 (MOut_0_reg_2 , clk , rst , MOut_0_reg_3);
bit_24_reg bit_24_reg_MOut_0_reg_4 (MOut_0_reg_3 , clk , rst , MOut_0_reg_4);

bit_24_reg bit_24_reg_MOut_1_reg_1 (MOut_1 , clk , rst , MOut_1_reg_1);
bit_24_reg bit_24_reg_MOut_1_reg_2 (MOut_1_reg_1 , clk , rst , MOut_1_reg_2);
bit_24_reg bit_24_reg_MOut_1_reg_3 (MOut_1_reg_2 , clk , rst , MOut_1_reg_3);
bit_24_reg bit_24_reg_MOut_1_reg_4 (MOut_1_reg_3 , clk , rst , MOut_1_reg_4);

bit_24_reg bit_24_reg_MOut_2_reg_1 (MOut_2 , clk , rst , MOut_2_reg_1);
bit_24_reg bit_24_reg_MOut_2_reg_2 (MOut_2_reg_1 , clk , rst , MOut_2_reg_2);
bit_24_reg bit_24_reg_MOut_2_reg_3 (MOut_2_reg_2 , clk , rst , MOut_2_reg_3);
bit_24_reg bit_24_reg_MOut_2_reg_4 (MOut_2_reg_3 , clk , rst , MOut_2_reg_4);

bit_24_reg bit_24_reg_MOut_3_reg_1 (MOut_3 , clk , rst , MOut_3_reg_1);
bit_24_reg bit_24_reg_MOut_3_reg_2 (MOut_3_reg_1 , clk , rst , MOut_3_reg_2);
bit_24_reg bit_24_reg_MOut_3_reg_3 (MOut_3_reg_2 , clk , rst , MOut_3_reg_3);
bit_24_reg bit_24_reg_MOut_3_reg_4 (MOut_3_reg_3 , clk , rst , MOut_3_reg_4);

bit_24_reg bit_24_reg_MOut_7_reg_1 (MOut_7 , clk , rst , MOut_7_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_1 (ovf_rnd_1 , clk , rst , ovf_rnd_1_reg_1);

bit_1_reg bit_1_reg_LSB_reg_1 (LSB , clk , rst , LSB_reg_1);
bit_1_reg bit_1_reg_LSB_reg_2 (LSB_reg_1 , clk , rst , LSB_reg_2);
bit_1_reg bit_1_reg_LSB_reg_3 (LSB_reg_2 , clk , rst , LSB_reg_3);

bit_24_reg bit_24_reg_MOut_6_reg_1 (MOut_6 , clk , rst , MOut_6_reg_1);
bit_24_reg bit_24_reg_MOut_6_reg_2 (MOut_6_reg_1 , clk , rst , MOut_6_reg_2);
bit_24_reg bit_24_reg_MOut_6_reg_3 (MOut_6_reg_2 , clk , rst , MOut_6_reg_3);

bit_1_reg bit_1_reg_ovf_rnd_0_sec_reg_1 (ovf_rnd_0 , clk , rst , ovf_rnd_0_sec_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_0_sec_reg_2 (ovf_rnd_0_sec_reg_1 , clk , rst , ovf_rnd_0_sec_reg_2);
bit_1_reg bit_1_reg_ovf_rnd_0_sec_reg_3 (ovf_rnd_0_sec_reg_2 , clk , rst , ovf_rnd_0_sec_reg_3);

bit_24_reg bit_24_reg_MOut_10_reg_1 (MOut_10 , clk , rst , MOut_10_reg_1);

bit_1_reg bit_1_reg_ovf_rnd_0_reg_1 (ovf_rnd_0 , clk , rst , ovf_rnd_0_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_0_reg_2 (ovf_rnd_0_reg_1 , clk , rst , ovf_rnd_0_reg_2);

bit_24_reg bit_24_reg_MOut_5_reg_1 (MOut_5 , clk , rst , MOut_5_reg_1);
bit_24_reg bit_24_reg_MOut_4_reg_1 (MOut_4 , clk , rst , MOut_4_reg_1);

bit_1_reg bit_1_reg_hidden_0_reg_1 (hidden_0 , clk , rst , hidden_0_reg_1);
bit_23_reg bit_23_reg_internal_mantessa_0_reg_1 (internal_mantessa_0 , clk , rst , internal_mantessa_0_reg_1);

bit_1_reg bit_1_reg_ovf_rnd_2_sec_reg_1 (ovf_rnd_2 , clk , rst , ovf_rnd_2_sec_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_2_sec_reg_2 (ovf_rnd_2_sec_reg_1 , clk , rst , ovf_rnd_2_sec_reg_2);
bit_1_reg bit_1_reg_ovf_rnd_2_sec_reg_3 (ovf_rnd_2_sec_reg_2 , clk , rst , ovf_rnd_2_sec_reg_3);
bit_1_reg bit_1_reg_ovf_rnd_2_sec_reg_4 (ovf_rnd_2_sec_reg_3 , clk , rst , ovf_rnd_2_sec_reg_4);

bit_24_reg bit_24_reg_MOut_33_reg_1 (MOut_33 , clk , rst , MOut_33_reg_1);
bit_24_reg bit_24_reg_MOut_33_reg_2 (MOut_33_reg_1 , clk , rst , MOut_33_reg_2);

bit_1_reg bit_1_reg_ovf_rnd_2_reg_1 (ovf_rnd_2 , clk , rst , ovf_rnd_2_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_2_reg_2 (ovf_rnd_2_reg_1 , clk , rst , ovf_rnd_2_reg_2);

bit_24_reg bit_24_reg_MOut_8_reg_1 (MOut_8 , clk , rst , MOut_8_reg_1);
bit_24_reg bit_24_reg_MOut_9_reg_1 (MOut_9 , clk , rst , MOut_9_reg_1);

bit_1_reg bit_1_reg_hidden_1_reg_1 (hidden_1 , clk , rst , hidden_1_reg_1);
bit_23_reg bit_23_reg_internal_mantessa_1_reg_1 (internal_mantessa_1 , clk , rst , internal_mantessa_1_reg_1);

bit_24_reg bit_24_reg_MOut_13_reg_1 (MOut_13 , clk , rst , MOut_13_reg_1);
bit_24_reg bit_24_reg_MOut_13_reg_2 (MOut_13_reg_1 , clk , rst , MOut_13_reg_2);

bit_1_reg bit_1_reg_ovf_rnd_3_sec_reg_1 (ovf_rnd_3 , clk , rst , ovf_rnd_3_sec_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_3_sec_reg_2 (ovf_rnd_3_sec_reg_1 , clk , rst , ovf_rnd_3_sec_reg_2);
bit_1_reg bit_1_reg_ovf_rnd_3_sec_reg_3 (ovf_rnd_3_sec_reg_2 , clk , rst , ovf_rnd_3_sec_reg_3);
bit_1_reg bit_1_reg_ovf_rnd_3_sec_reg_4 (ovf_rnd_3_sec_reg_3 , clk , rst , ovf_rnd_3_sec_reg_4);

bit_1_reg bit_1_reg_ovf_rnd_3_reg_1 (ovf_rnd_3 , clk , rst , ovf_rnd_3_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_3_reg_2 (ovf_rnd_3_reg_1 , clk , rst , ovf_rnd_3_reg_2);

bit_24_reg bit_24_reg_MOut_11_reg_1 (MOut_11 , clk , rst , MOut_11_reg_1);
bit_24_reg bit_24_reg_MOut_12_reg_1 (MOut_12 , clk , rst , MOut_12_reg_1);

bit_1_reg bit_1_reg_hidden_2_reg_1 (hidden_2 , clk , rst , hidden_2_reg_1);
bit_23_reg bit_23_reg_internal_mantessa_2_reg_1 (internal_mantessa_2 , clk , rst , internal_mantessa_2_reg_1);

bit_24_reg bit_24_reg_MOut_16_reg_1 (MOut_16 , clk , rst , MOut_16_reg_1);
bit_24_reg bit_24_reg_MOut_16_reg_2 (MOut_16_reg_1 , clk , rst , MOut_16_reg_2);

bit_1_reg bit_1_reg_ovf_rnd_4_sec_reg_1 (ovf_rnd_4 , clk , rst , ovf_rnd_4_sec_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_4_sec_reg_2 (ovf_rnd_4_sec_reg_1 , clk , rst , ovf_rnd_4_sec_reg_2);
bit_1_reg bit_1_reg_ovf_rnd_4_sec_reg_3 (ovf_rnd_4_sec_reg_2 , clk , rst , ovf_rnd_4_sec_reg_3);
bit_1_reg bit_1_reg_ovf_rnd_4_sec_reg_4 (ovf_rnd_4_sec_reg_3 , clk , rst , ovf_rnd_4_sec_reg_4);

bit_1_reg bit_1_reg_ovf_rnd_4_reg_1 (ovf_rnd_4 , clk , rst , ovf_rnd_4_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_4_reg_2 (ovf_rnd_4_reg_1 , clk , rst , ovf_rnd_4_reg_2);

bit_24_reg bit_24_reg_MOut_14_reg_1 (MOut_14 , clk , rst , MOut_14_reg_1);
bit_24_reg bit_24_reg_MOut_15_reg_1 (MOut_15 , clk , rst , MOut_15_reg_1);

bit_1_reg bit_1_reg_hidden_3_reg_1 (hidden_3 , clk , rst , hidden_3_reg_1);
bit_23_reg bit_23_reg_internal_mantessa_3_reg_1 (internal_mantessa_3 , clk , rst , internal_mantessa_3_reg_1);

bit_3_reg bit_3_reg_guard_bits_reg_1 (guard_bits , clk , rst , guard_bits_reg_1);
bit_3_reg bit_3_reg_guard_bits_reg_2 (guard_bits_reg_1 , clk , rst , guard_bits_reg_2);
bit_3_reg bit_3_reg_guard_bits_reg_3 (guard_bits_reg_2 , clk , rst , guard_bits_reg_3);
bit_3_reg bit_3_reg_guard_bits_reg_4 (guard_bits_reg_3 , clk , rst , guard_bits_reg_4);

bit_24_reg bit_24_reg_MOut_20_reg_1 (MOut_20 , clk , rst , MOut_20_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_6_reg_1 (ovf_rnd_6 , clk , rst , ovf_rnd_6_reg_1);

bit_24_reg bit_24_reg_MOut_19_reg_1 (MOut_19 , clk , rst , MOut_19_reg_1);
bit_24_reg bit_24_reg_MOut_19_reg_2 (MOut_19_reg_1 , clk , rst , MOut_19_reg_2);
bit_24_reg bit_24_reg_MOut_19_reg_3 (MOut_19_reg_2 , clk , rst , MOut_19_reg_3);

bit_24_reg bit_24_reg_MOut_18_reg_1 (MOut_18 , clk , rst , MOut_18_reg_1);

bit_1_reg bit_1_reg_ovf_rnd_5_sec_reg_1 (ovf_rnd_5 , clk , rst , ovf_rnd_5_sec_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_5_sec_reg_2 (ovf_rnd_5_sec_reg_1 , clk , rst , ovf_rnd_5_sec_reg_2);
bit_1_reg bit_1_reg_ovf_rnd_5_sec_reg_3 (ovf_rnd_5_sec_reg_2 , clk , rst , ovf_rnd_5_sec_reg_3);

bit_1_reg bit_1_reg_ovf_rnd_5_reg_1 (ovf_rnd_5 , clk , rst , ovf_rnd_5_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_5_reg_2 (ovf_rnd_5_reg_1 , clk , rst , ovf_rnd_5_reg_2);

bit_24_reg bit_24_reg_MOut_30_reg_1 (MOut_30 , clk , rst , MOut_30_reg_1);
bit_24_reg bit_24_reg_MOut_31_reg_1 (MOut_31 , clk , rst , MOut_31_reg_1);

bit_1_reg bit_1_reg_hidden_4_reg_1 (hidden_4 , clk , rst , hidden_4_reg_1);
bit_23_reg bit_23_reg_internal_mantessa_4_reg_1 (internal_mantessa_4 , clk , rst , internal_mantessa_4_reg_1);

bit_24_reg bit_24_reg_MOut_23_reg_1 (MOut_23 , clk , rst , MOut_23_reg_1);
bit_24_reg bit_24_reg_MOut_23_reg_2 (MOut_23_reg_1 , clk , rst , MOut_23_reg_2);
bit_24_reg bit_24_reg_MOut_23_reg_3 (MOut_23_reg_2 , clk , rst , MOut_23_reg_3);
bit_24_reg bit_24_reg_MOut_23_reg_4 (MOut_23_reg_3 , clk , rst , MOut_23_reg_4);

bit_24_reg bit_24_reg_MOut_28_reg_1 (MOut_28 , clk , rst , MOut_28_reg_1);

bit_1_reg bit_1_reg_ovf_rnd_10_reg_1 (ovf_rnd_10 , clk , rst , ovf_rnd_10_reg_1);

bit_24_reg bit_24_reg_MOut_24_reg_1 (MOut_24 , clk , rst , MOut_24_reg_1);
bit_24_reg bit_24_reg_MOut_24_reg_2 (MOut_24_reg_1 , clk , rst , MOut_24_reg_2);
bit_24_reg bit_24_reg_MOut_24_reg_3 (MOut_24_reg_2 , clk , rst , MOut_24_reg_3);

bit_24_reg bit_24_reg_MOut_27_reg_1 (MOut_27 , clk , rst , MOut_27_reg_1);

bit_1_reg bit_1_reg_ovf_rnd_9_sec_reg_1 (ovf_rnd_9 , clk , rst , ovf_rnd_9_sec_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_9_sec_reg_2 (ovf_rnd_9_sec_reg_1 , clk , rst , ovf_rnd_9_sec_reg_2);
bit_1_reg bit_1_reg_ovf_rnd_9_sec_reg_3 (ovf_rnd_9_sec_reg_2 , clk , rst , ovf_rnd_9_sec_reg_3);

bit_1_reg bit_1_reg_ovf_rnd_9_reg_1 (ovf_rnd_9 , clk , rst , ovf_rnd_9_reg_1);
bit_1_reg bit_1_reg_ovf_rnd_9_reg_2 (ovf_rnd_9_reg_1 , clk , rst , ovf_rnd_9_reg_2);

bit_24_reg bit_24_reg_MOut_25_reg_1 (MOut_25 , clk , rst , MOut_25_reg_1);
bit_24_reg bit_24_reg_MOut_26_reg_1 (MOut_26 , clk , rst , MOut_26_reg_1);

bit_1_reg bit_1_reg_hidden_5_reg_1 (hidden_5 , clk , rst , hidden_5_reg_1);

bit_23_reg bit_23_reg_internal_mantessa_5_reg_1 (internal_mantessa_5 , clk , rst , internal_mantessa_5_reg_1);

bit_24_reg bit_24_reg_MOut_32_reg_1 (MOut_32 , clk , rst , MOut_32_reg_1);
bit_24_reg bit_24_reg_MOut_32_reg_2 (MOut_32_reg_1 , clk , rst , MOut_32_reg_2);
bit_24_reg bit_24_reg_MOut_32_reg_3 (MOut_32_reg_2 , clk , rst , MOut_32_reg_3);
bit_24_reg bit_24_reg_MOut_32_reg_4 (MOut_32_reg_3 , clk , rst , MOut_32_reg_4);

bit_1_reg bit_1_reg_sign_in_reg_1 (Sign_in , clk , rst , sign_in_reg_1);
bit_1_reg bit_1_reg_sign_in_reg_2 (sign_in_reg_1 , clk , rst , sign_in_reg_2);
bit_1_reg bit_1_reg_sign_in_reg_3 (sign_in_reg_2 , clk , rst , sign_in_reg_3);
bit_1_reg bit_1_reg_sign_in_reg_4 (sign_in_reg_3 , clk , rst , sign_in_reg_4);

bit_1_reg bit_1_reg_inexact_flag_reg_1 (inexact_flag , clk , rst , inexact_flag_reg_1);
bit_1_reg bit_1_reg_inexact_flag_reg_2 (inexact_flag_reg_1 , clk , rst , inexact_flag_reg_2);
bit_1_reg bit_1_reg_inexact_flag_reg_3 (inexact_flag_reg_2 , clk , rst , inexact_flag_reg_3);
bit_1_reg bit_1_reg_inexact_flag_reg_4 (inexact_flag_reg_3 , clk , rst , inexact_flag_reg_4);
bit_1_reg bit_1_reg_inexact_flag_reg_5 (inexact_flag_reg_4 , clk , rst , inexact_flag_reg_5);

//instances
mux_4_in_2_out mux_4_in_2_out_inst ({ovf_rnd_7_reg_1 , MOut_21_reg_1} , {zero_signal_1_bit , MOut_17_reg_5} , {ovf_rnd_8_reg_1 , MOut_22_reg_1} , {ovf_rnd_11_reg_1 , MOut_29_reg_1} , roundMode_reg_5 , MOut , ovf_rnd);
mux_8_in_2_out mux_8_in_2_out_inst ({zero_signal_1_bit , MOut_0_reg_4} , {zero_signal_1_bit , MOut_1_reg_4} , {zero_signal_1_bit , MOut_2_reg_4} , {zero_signal_1_bit , MOut_3_reg_4} , {ovf_rnd_1_reg_1 , MOut_7_reg_1} , {ovf_rnd_2_sec_reg_4 , MOut_33_reg_2} , {ovf_rnd_3_sec_reg_4 , MOut_13_reg_2} , {ovf_rnd_4_sec_reg_4 , MOut_16_reg_2} , guard_bits_reg_4 , MOut_21 , ovf_rnd_7);
round_2 round_2_inst_1 (Min , MOut_0);
round_2 round_2_inst_2 (Min , MOut_1);
round_2 round_2_inst_3 (Min , MOut_2);
round_2 round_2_inst_4 (Min , MOut_3);
mux_2_in_2_out_25_bits mux_2_in_2_out_25_bits_inst_1 ({zero_signal_1_bit , MOut_6_reg_3} , {ovf_rnd_0_sec_reg_3 , MOut_10_reg_1} , LSB_reg_3 , MOut_7 , ovf_rnd_1);
round_6 round_6_inst_1 (Min , MOut_6);
round_3 round_3_inst_1 (Min , ovf_rnd_0 , hidden_0 , internal_mantessa_0);
mux_2_in_1_out_24_bits mux_2_in_1_out_24_bits_inst_1 (MOut_5_reg_1 , MOut_4_reg_1 , ovf_rnd_0_reg_2 , MOut_10);
round_5 round_5_inst_1 (hidden_0_reg_1 , internal_mantessa_0_reg_1 , MOut_5);
round_4 round_4_inst_1 (hidden_0_reg_1 , internal_mantessa_0_reg_1 , MOut_4);
round_3 round_3_inst_2 (Min , ovf_rnd_2 , hidden_1 , internal_mantessa_1);
mux_2_in_1_out_24_bits mux_2_in_1_out_24_bits_inst_2 (MOut_8_reg_1 , MOut_9_reg_1 , ovf_rnd_2_reg_2 , MOut_33);
round_5 round_5_inst_2 (hidden_1_reg_1 , internal_mantessa_1_reg_1 , MOut_8);
round_4 round_4_inst_2 (hidden_1_reg_1 , internal_mantessa_1_reg_1 , MOut_9);
round_3 round_3_inst_3 (Min , ovf_rnd_3 , hidden_2 , internal_mantessa_2);
mux_2_in_1_out_24_bits mux_2_in_1_out_24_bits_inst_3 (MOut_11_reg_1 , MOut_12_reg_1 , ovf_rnd_3_reg_2 , MOut_13);
round_5 round_5_inst_3 (hidden_2_reg_1 , internal_mantessa_2_reg_1 , MOut_11);
round_4 round_4_inst_3 (hidden_2_reg_1 , internal_mantessa_2_reg_1 , MOut_12);
round_3 round_3_inst_4 (Min , ovf_rnd_4 , hidden_3 , internal_mantessa_3);
mux_2_in_1_out_24_bits mux_2_in_1_out_24_bits_inst_4 (MOut_14_reg_1 , MOut_15_reg_1 , ovf_rnd_4_reg_2 , MOut_16);
round_5 round_5_inst_4 (hidden_3_reg_1 , internal_mantessa_3_reg_1 , MOut_14);
round_4 round_4_inst_4 (hidden_3_reg_1 , internal_mantessa_3_reg_1 , MOut_15);
round_6 round_6_inst_2 (Min , MOut_17);
mux_2_in_2_out_25_bits mux_2_in_2_out_25_bits_inst_2 ({ovf_rnd_6_reg_1 , MOut_20_reg_1} , {zero_signal_1_bit , MOut_23_reg_4} , sign_in_reg_4 , MOut_22 , ovf_rnd_8);
mux_2_in_2_out_3_bits_sel mux_2_in_2_out_3_bits_sel_inst_1 ({zero_signal_1_bit , MOut_19_reg_3} , {ovf_rnd_5_sec_reg_3 , MOut_18_reg_1} , guard_bits_reg_3 , MOut_20 , ovf_rnd_6);
round_6 round_6_inst_3 (Min , MOut_19);
round_3 round_3_inst_5 (Min , ovf_rnd_5 , hidden_4 , internal_mantessa_4);
mux_2_in_1_out_24_bits mux_2_in_1_out_24_bits_inst_5 (MOut_30_reg_1 , MOut_31_reg_1 , ovf_rnd_5_reg_2 , MOut_18);
round_5 round_5_inst_5 (hidden_4_reg_1 , internal_mantessa_4_reg_1 , MOut_30);
round_4 round_4_inst_5 (hidden_4_reg_1 , internal_mantessa_4_reg_1 , MOut_31);
round_6 round_6_inst_4 (Min , MOut_23);
mux_2_in_2_out_25_bits mux_2_in_2_out_25_bits_inst_3 ({ovf_rnd_10_reg_1 , MOut_28_reg_1} , {zero_signal_1_bit , MOut_32_reg_4} , sign_in_reg_4 , MOut_29 , ovf_rnd_11);
mux_2_in_2_out_3_bits_sel mux_2_in_2_out_3_bits_sel_inst_2 ({zero_signal_1_bit , MOut_24_reg_3} , {ovf_rnd_9_sec_reg_3 , MOut_27_reg_1} , guard_bits_reg_3 , MOut_28 , ovf_rnd_10);
round_2 round_2_inst_5 (Min , MOut_24);
round_3 round_3_inst_6 (Min , ovf_rnd_9 , hidden_5 , internal_mantessa_5);
mux_2_in_1_out_24_bits mux_2_in_1_out_24_bits_inst_6 (MOut_25_reg_1 , MOut_26_reg_1 , ovf_rnd_9_reg_2 , MOut_27);
round_5 round_5_inst_6 (hidden_5_reg_1 , internal_mantessa_5_reg_1 , MOut_25);
round_4 round_4_inst_6 (hidden_5_reg_1 , internal_mantessa_5_reg_1 , MOut_26);
round_2 round_2_inst_6 (Min , MOut_32);
round_1 round_1_inst (Min , inexact_flag);
endmodule