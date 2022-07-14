    module LZA_and_massive_SHL (A , B , adder_out , final_shift_left , correct_sum_shifted_rtl_1 , clk , rst);
//inputs and outputs
input [26:0]A , B , adder_out;
input clk , rst;
output [4:0]final_shift_left;
output [23:0]correct_sum_shifted_rtl_1;
//outputs taken from submodule in LZA_and_massive_SHL
///output [26:0]E;
///output [4:0]SHL; 
wire [4:0]SHL;      
///output [58:0]sum_shifted;   
///output second_shift_left;
wire second_shift_left; 
//internal signals
wire [26:0]E;       //not exponent
///wire [4:0]SHL;       
wire [26:0]sum_shifted;   
///wire second_shift_left; 
//optimization wires
wire [26:0]E_rtl_1;
wire [4:0]SHL_rtl_1;      
wire [4:0]SHL_rtl_2;
wire [4:0]SHL_rtl_3;
wire [26:0]adder_out_rtl_1;
wire [26:0]adder_out_rtl_2;
wire [26:0]sum_shifted_rtl_1;
wire [23:0]correct_sum_shifted;
wire second_shift_left_rtl_1;
//optimization registers
bit_27_reg bit_27_reg_E_rtl_1 (E , clk , rst , E_rtl_1);
bit_5_reg bit_5_reg_SHL_rtl_1 (SHL , clk , rst , SHL_rtl_1);
bit_5_reg bit_5_reg_SHL_rtl_2 (SHL_rtl_1 , clk , rst , SHL_rtl_2);
bit_5_reg bit_5_reg_SHL_rtl_3 (SHL_rtl_2 , clk , rst , SHL_rtl_3);
bit_27_reg bit_27_reg_adder_out_rtl_1 (adder_out , clk , rst , adder_out_rtl_1);
bit_27_reg bit_27_reg_adder_out_rtl_2 (adder_out_rtl_1 , clk , rst , adder_out_rtl_2);
bit_27_reg bit_27_reg_sum_shifted_rtl_1 (sum_shifted , clk , rst , sum_shifted_rtl_1);
bit_24_reg bit_24_reg_correct_sum_shifted_rtl_1 (correct_sum_shifted , clk , rst , correct_sum_shifted_rtl_1);
bit_1_reg bit_1_reg_second_shift_left_rtl_1 (second_shift_left , clk , rst , second_shift_left_rtl_1);
//instances
LZA_1_modified LZA_1_modified_inst (A , B , E);
LZA_2_modified LZA_2_modified_inst (E_rtl_1 , SHL);
first_massive_shift_left first_massive_shift_left_inst (adder_out_rtl_2 , SHL_rtl_1 , sum_shifted);
LZA_final_modified LZA_final_modified_inst (sum_shifted_rtl_1 , correct_sum_shifted , second_shift_left);
shift_left_adder shift_left_adder_inst (SHL_rtl_3 , second_shift_left_rtl_1 , final_shift_left);
endmodule