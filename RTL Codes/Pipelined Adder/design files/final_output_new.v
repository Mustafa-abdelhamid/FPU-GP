module final_output_new (
input wire [23:0] mantessa_mux_out ,
input wire [7:0]E_exponent_update,
input wire [9:0]excessive_shift_left,
input wire  overflow_flag , underflow_flag , invalid_flag , 
output	wire [22:0] final_M_out ,
output	wire [7:0] final_E_out ,
input clk,
input rst
);
//internal_signals
wire [22:0]final_M_out_0;
wire [22:0]final_M_out_1;
wire [22:0]final_M_out_2;
wire [7:0]final_E_out_0;
wire [7:0]final_E_out_1;
wire [7:0]zero_signal_8_bits;
wire [22:0]zero_signal_23_bits;
wire [7:0]one_signal_8_bits;
//internal signals for RTL optimization regs
wire [7:0]final_E_out_1_reg_1;
wire [22:0]final_M_out_1_reg_1;
wire [22:0]final_M_out_2_reg_1;
wire underflow_flag_reg_1;
wire [7:0]final_E_out_0_reg_1;
wire [22:0]final_M_out_0_reg_1;
wire overflow_flag_reg_1;
wire overflow_flag_reg_2;
//assignments
assign zero_signal_8_bits = 8'b 0000_0000;
assign zero_signal_23_bits = 23'b 0000_0000_0000_0000_0000_000;
assign one_signal_8_bits = 8'b 1111_1111;
//instances for RTL optimization regs
bit_8_reg bit_8_reg_final_E_out_1_reg_1 (final_E_out_1 , clk , rst , final_E_out_1_reg_1);
bit_23_reg bit_23_reg_final_M_out_1_reg_1 (final_M_out_1 , clk , rst , final_M_out_1_reg_1);
bit_23_reg bit_23_reg_final_M_out_2_reg_1 (final_M_out_2 , clk , rst , final_M_out_2_reg_1);
bit_1_reg bit_1_reg_underflow_flag_reg_1 (underflow_flag , clk , rst , underflow_flag_reg_1);
bit_8_reg bit_8_reg_final_E_out_0_reg_1 (final_E_out_0 , clk , rst , final_E_out_0_reg_1);
bit_23_reg bit_23_reg_final_M_out_0_reg_1 (final_M_out_0 , clk , rst , final_M_out_0_reg_1);
bit_1_reg bit_1_reg_overflow_flag_reg_1 (overflow_flag , clk , rst , overflow_flag_reg_1);
bit_1_reg bit_1_reg_overflow_flag_reg_2 (overflow_flag_reg_1 , clk , rst , overflow_flag_reg_2);
//instances
mux_2_in_2_out_31_bits_int mux_2_in_2_out_31_bits_int_inst_1 ({final_E_out_0_reg_1 , final_M_out_0_reg_1} , {one_signal_8_bits , zero_signal_23_bits} , overflow_flag_reg_2 , final_M_out , final_E_out);
mux_2_in_2_out_31_bits_int mux_2_in_2_out_31_bits_int_inst_2 ({final_E_out_1_reg_1 , final_M_out_1_reg_1} , {zero_signal_8_bits , final_M_out_2_reg_1} , underflow_flag_reg_1 , final_M_out_0 , final_E_out_0);
mux_2_in_2_out_31_bits mux_2_in_2_out_31_bits_inst_1 ({E_exponent_update , mantessa_mux_out} , {zero_signal_8_bits , zero_signal_23_bits} , invalid_flag , final_M_out_1 , final_E_out_1);
final_output_1 final_output_1_inst (mantessa_mux_out , excessive_shift_left , final_M_out_2);
endmodule