module mantessa_mux_1 (most_bits_of_adder_out , choose_left);
input [2:0]most_bits_of_adder_out;
output reg choose_left;
always@(*)
begin
    choose_left = ~| most_bits_of_adder_out;
end
endmodule