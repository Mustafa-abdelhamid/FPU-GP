module LZA_and_massive_SHL (A , B , adder_out , final_shift_left , correct_sum_shifted);
//inputs and outputs
input [26:0]A , B , adder_out;
output [4:0]final_shift_left;
output [23:0]correct_sum_shifted;
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
//instances
LZA_1_modified LZA_1_modified_inst (A , B , E);
LZA_2_modified LZA_2_modified_inst (E , SHL);
first_massive_shift_left first_massive_shift_left_inst (adder_out , SHL , sum_shifted);
LZA_final_modified LZA_final_modified_inst (sum_shifted , correct_sum_shifted , second_shift_left);
shift_left_adder shift_left_adder_inst (SHL , second_shift_left , final_shift_left);
endmodule