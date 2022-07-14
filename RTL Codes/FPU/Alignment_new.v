module Alignment_new (
input	wire	[22:0]	Mx,
input	wire	[22:0]	My,

input	wire 	[7:0]	d, //from body & atef 
input	wire 	[7:0]	Ex,
input	wire 	[7:0]	Ey,
input 	wire			sgn_d,
input	wire			EOP,
input	wire			zero_d,
output	wire		       	Cmp,
output	wire		[26:0]	out_11,
output	wire		[26:0]	out_22,
input clk,
input rst
);
//internal signals
wire		[23:0]	out_x;// 22 or 25?
wire		[23:0]	out_y;

wire		[23:0]	bef_shift_y; //before shift y
wire		[23:0]	bef_shift_x; //before shoft x

wire		[52:0]	shR_y;
wire		[52:0]	out_y_shR;   // gaurd bits ??
wire     [26:0]  out_y_with_T;
wire     [26:0]  out_y_with_T_4_1;
wire     [26:0]  out_y_with_T_4_4;
wire             sticky;	

wire		[26:0]	out_x_shR;


wire 			bit_inv_cont_x;
wire 			bit_inv_cont_y;
wire 			bit_inv_cont_x_3;
wire 			bit_inv_cont_y_3;
wire 			bit_inv_cont_x_2;
wire 			bit_inv_cont_y_2;
wire zero_signal_1_bit;
wire one_signal_1_bit;
//assignments
assign zero_signal_1_bit = 0;
assign one_signal_1_bit = 1;
//RTL optimization internal signals
wire		[23:0]	bef_shift_x_rtl_1;
wire		[23:0]	bef_shift_y_rtl_1;
wire sgn_d_rtl_1;
wire		[23:0]	out_x_rtl_1;
wire		[23:0]	out_y_rtl_1;
wire		[52:0]	shR_y_rtl_1;
wire		[26:0]	out_x_shR_rtl_1;
wire		[26:0]	out_x_shR_rtl_2;
wire		[26:0]	out_x_shR_rtl_3;
wire		[26:0]	out_x_shR_rtl_4;
wire		[26:0]	out_x_shR_rtl_5;
wire 	[7:0]	d_rtl_1;
wire 	[7:0]	d_rtl_2;
wire 	[7:0]	d_rtl_3;
wire 	[7:0]	d_rtl_4;
wire 	[7:0]	d_rtl_5;
wire 	[7:0]	d_rtl_6;
wire		[52:0]	out_y_shR_rtl_1;
wire		[52:0]	out_y_shR_rtl_2;
wire sticky_rtl_1;
wire     [26:0]  out_y_with_T_4_1_rtl_1;
wire     [26:0]  out_y_with_T_4_1_rtl_2;
wire     [26:0]  out_y_with_T_4_1_rtl_3;
wire     [26:0]  out_y_with_T_4_4_rtl_1;
wire		       	Cmp_rtl_1;
wire		       	Cmp_rtl_2;
wire		       	Cmp_rtl_3;
wire		       	Cmp_rtl_4;
wire		       	Cmp_rtl_5;
wire		       	Cmp_rtl_6;
wire		       	Cmp_rtl_7;
wire bit_inv_cont_x_3_rtl_1;
wire bit_inv_cont_y_3_rtl_1;
wire zero_d_rtl_1;
wire zero_d_rtl_2;
wire bit_inv_cont_x_2_rtl_1;
wire bit_inv_cont_y_2_rtl_1;
wire EOP_rtl_1;
wire EOP_rtl_2;
wire EOP_rtl_3;
wire bit_inv_cont_x_rtl_1;
wire bit_inv_cont_x_rtl_2;
wire bit_inv_cont_x_rtl_3;
wire bit_inv_cont_x_rtl_4;
wire bit_inv_cont_y_rtl_1;
wire bit_inv_cont_y_rtl_2;
wire bit_inv_cont_y_rtl_3;
wire bit_inv_cont_y_rtl_4;
wire     [26:0]  out_y_with_T_rtl_1;
//instances for rtl optimization registers
bit_24_reg bit_24_reg_bef_shift_x_rtl_1 (bef_shift_x , clk , rst , bef_shift_x_rtl_1);
bit_24_reg bit_24_reg_bef_shift_y_rtl_1 (bef_shift_y , clk , rst , bef_shift_y_rtl_1);
bit_1_reg bit_1_reg_sgn_d_rtl_1 (sgn_d , clk , rst , sgn_d_rtl_1);
bit_24_reg bit_24_reg_out_x_rtl_1 (out_x , clk , rst , out_x_rtl_1);
bit_24_reg bit_24_reg_out_y_rtl_1 (out_y , clk , rst , out_y_rtl_1);
bit_53_reg bit_53_reg_shR_y_rtl_1 (shR_y , clk , rst , shR_y_rtl_1);
bit_27_reg bit_27_reg_out_x_shR_rtl_1 (out_x_shR , clk , rst , out_x_shR_rtl_1);
bit_27_reg bit_27_reg_out_x_shR_rtl_2 (out_x_shR_rtl_1 , clk , rst , out_x_shR_rtl_2);
bit_27_reg bit_27_reg_out_x_shR_rtl_3 (out_x_shR_rtl_2 , clk , rst , out_x_shR_rtl_3);
bit_27_reg bit_27_reg_out_x_shR_rtl_4 (out_x_shR_rtl_3 , clk , rst , out_x_shR_rtl_4);
bit_27_reg bit_27_reg_out_x_shR_rtl_5 (out_x_shR_rtl_4 , clk , rst , out_x_shR_rtl_5);
bit_8_reg bit_8_reg_d_rtl_1 (d , clk , rst , d_rtl_1);
bit_8_reg bit_8_reg_d_rtl_2 (d_rtl_1 , clk , rst , d_rtl_2);
bit_8_reg bit_8_reg_d_rtl_3 (d_rtl_2 , clk , rst , d_rtl_3);
bit_8_reg bit_8_reg_d_rtl_4 (d_rtl_3 , clk , rst , d_rtl_4);
bit_8_reg bit_8_reg_d_rtl_5 (d_rtl_4 , clk , rst , d_rtl_5);
bit_8_reg bit_8_reg_d_rtl_6 (d_rtl_5 , clk , rst , d_rtl_6);
bit_53_reg bit_53_reg_out_y_shR_rtl_1 (out_y_shR , clk , rst , out_y_shR_rtl_1);
bit_53_reg bit_53_reg_out_y_shR_rtl_2 (out_y_shR_rtl_1 , clk , rst , out_y_shR_rtl_2);
bit_1_reg bit_1_reg_sticky_rtl_1 (sticky , clk , rst , sticky_rtl_1);
bit_27_reg bit_27_reg_out_y_with_T_4_1_rtl_1 (out_y_with_T_4_1 , clk , rst , out_y_with_T_4_1_rtl_1);
bit_27_reg bit_27_reg_out_y_with_T_4_1_rtl_2 (out_y_with_T_4_1_rtl_1 , clk , rst , out_y_with_T_4_1_rtl_2);
bit_27_reg bit_27_reg_out_y_with_T_4_1_rtl_3 (out_y_with_T_4_1_rtl_2 , clk , rst , out_y_with_T_4_1_rtl_3);
bit_27_reg bit_27_reg_out_y_with_T_4_4_rtl_1 (out_y_with_T_4_4 , clk , rst , out_y_with_T_4_4_rtl_1);
bit_1_reg bit_1_reg_Cmp_rtl_1 (Cmp , clk , rst , Cmp_rtl_1);
bit_1_reg bit_1_reg_Cmp_rtl_2 (Cmp_rtl_1 , clk , rst , Cmp_rtl_2);
bit_1_reg bit_1_reg_Cmp_rtl_3 (Cmp_rtl_2 , clk , rst , Cmp_rtl_3);
bit_1_reg bit_1_reg_Cmp_rtl_4 (Cmp_rtl_3 , clk , rst , Cmp_rtl_4);
bit_1_reg bit_1_reg_Cmp_rtl_5 (Cmp_rtl_4 , clk , rst , Cmp_rtl_5);
bit_1_reg bit_1_reg_Cmp_rtl_6 (Cmp_rtl_5 , clk , rst , Cmp_rtl_6);
bit_1_reg bit_1_reg_Cmp_rtl_7 (Cmp_rtl_6 , clk , rst , Cmp_rtl_7);
bit_1_reg bit_1_reg_bit_inv_cont_x_3_rtl_1 (bit_inv_cont_x_3 , clk , rst , bit_inv_cont_x_3_rtl_1);
bit_1_reg bit_1_reg_bit_inv_cont_y_3_rtl_1 (bit_inv_cont_y_3 , clk , rst , bit_inv_cont_y_3_rtl_1);
bit_1_reg bit_1_reg_zero_d_rtl_1 (zero_d , clk , rst , zero_d_rtl_1);
bit_1_reg bit_1_reg_zero_d_rtl_2 (zero_d_rtl_1 , clk , rst , zero_d_rtl_2);
bit_1_reg bit_1_reg_bit_inv_cont_x_2_rtl_1 (bit_inv_cont_x_2 , clk , rst , bit_inv_cont_x_2_rtl_1);
bit_1_reg bit_1_reg_bit_inv_cont_y_2_rtl_1 (bit_inv_cont_y_2 , clk , rst , bit_inv_cont_y_2_rtl_1);
bit_1_reg bit_1_reg_EOP_rtl_1 (EOP , clk , rst , EOP_rtl_1);
bit_1_reg bit_1_reg_EOP_rtl_2 (EOP_rtl_1 , clk , rst , EOP_rtl_2);
bit_1_reg bit_1_reg_EOP_rtl_3 (EOP_rtl_2 , clk , rst , EOP_rtl_3);
bit_1_reg bit_1_reg_bit_inv_cont_x_rtl_1 (bit_inv_cont_x , clk , rst , bit_inv_cont_x_rtl_1);
bit_1_reg bit_1_reg_bit_inv_cont_x_rtl_2 (bit_inv_cont_x_rtl_1 , clk , rst , bit_inv_cont_x_rtl_2);
bit_1_reg bit_1_reg_bit_inv_cont_x_rtl_3 (bit_inv_cont_x_rtl_2 , clk , rst , bit_inv_cont_x_rtl_3);
bit_1_reg bit_1_reg_bit_inv_cont_x_rtl_4 (bit_inv_cont_x_rtl_3 , clk , rst , bit_inv_cont_x_rtl_4);
bit_1_reg bit_1_reg_bit_inv_cont_y_rtl_1 (bit_inv_cont_y , clk , rst , bit_inv_cont_y_rtl_1);
bit_1_reg bit_1_reg_bit_inv_cont_y_rtl_2 (bit_inv_cont_y_rtl_1 , clk , rst , bit_inv_cont_y_rtl_2);
bit_1_reg bit_1_reg_bit_inv_cont_y_rtl_3 (bit_inv_cont_y_rtl_2 , clk , rst , bit_inv_cont_y_rtl_3);
bit_1_reg bit_1_reg_bit_inv_cont_y_rtl_4 (bit_inv_cont_y_rtl_3 , clk , rst , bit_inv_cont_y_rtl_4);
bit_27_reg bit_27_reg_out_y_with_T_rtl_1 (out_y_with_T , clk , rst , out_y_with_T_rtl_1);
//instances
Alignment_1 Alignment_1_inst (Ex , Ey , Mx , My , bef_shift_x , bef_shift_y);
Alignment_2 Alignment_2_inst (bef_shift_x_rtl_1 , bef_shift_y_rtl_1 , sgn_d_rtl_1 , out_x , out_y);
Alignment_3 Alignment_3_inst (out_x_rtl_1 , out_y_rtl_1 , shR_y , out_x_shR);
Alignment_4_1 Alignment_4_1_inst (shR_y_rtl_1 , out_y_with_T_4_1);
Alignment_4_2 Alignment_4_2_inst (shR_y_rtl_1 , d_rtl_3 , out_y_shR);
Alignment_4_3 Alignment_4_3_inst (out_y_shR_rtl_1 , sticky);
Alignment_4_4 Alignment_4_4_inst (out_y_shR_rtl_2 , sticky_rtl_1 , out_y_with_T_4_4);
mux_2_in_1_out_8_bits_sel mux_2_in_1_out_8_bits_sel_inst (out_y_with_T_4_1_rtl_3 , out_y_with_T_4_4_rtl_1 , d_rtl_6 , out_y_with_T);
Alignment_5 Alignment_5_inst (Mx , My , Cmp);
mux_2_in_2_out mux_2_in_2_out_inst_3 ({zero_signal_1_bit , one_signal_1_bit} , {one_signal_1_bit , zero_signal_1_bit} , Cmp_rtl_1 , bit_inv_cont_y_3 , bit_inv_cont_x_3);
mux_2_in_2_out mux_2_in_2_out_inst_2 ({zero_signal_1_bit , one_signal_1_bit} , {bit_inv_cont_x_3_rtl_1 , bit_inv_cont_y_3_rtl_1} , zero_d_rtl_2 , bit_inv_cont_y_2 , bit_inv_cont_x_2);
mux_2_in_2_out mux_2_in_2_out_inst_1 ({zero_signal_1_bit , zero_signal_1_bit} , {bit_inv_cont_x_2_rtl_1 , bit_inv_cont_y_2_rtl_1} , EOP_rtl_3 , bit_inv_cont_y , bit_inv_cont_x);
Alignment_7 Alignment_7_inst (bit_inv_cont_x_rtl_4 , bit_inv_cont_y_rtl_4 , out_x_shR_rtl_5 , out_y_with_T_rtl_1 , out_11 , out_22);
endmodule