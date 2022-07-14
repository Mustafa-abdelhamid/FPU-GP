module mantessa_mux_new (left_path , right_path , most_bits_of_adder_out , mantessa_mux_out);
input [23:0]left_path ;
input [23:0]right_path;
input [2:0]most_bits_of_adder_out;
output wire [23:0]mantessa_mux_out;
//internal signals
wire choose_left;
//instances
mantessa_mux_1 mantessa_mux_1_inst (most_bits_of_adder_out , choose_left);
mantessa_mux_2 mantessa_mux_2_inst (choose_left , left_path , right_path , mantessa_mux_out);
endmodule