module mantessa_mux (left_path , right_path , most_bits_of_adder_out , mantessa_mux_out);
input [23:0]left_path ;
input [23:0]right_path;
input [2:0]most_bits_of_adder_out;
output reg [23:0]mantessa_mux_out;

assign choose_left = ~| most_bits_of_adder_out;
always@(*)
begin
    if(choose_left)
        begin
            mantessa_mux_out = left_path;
        end
    else
        begin
            mantessa_mux_out = right_path;
        end
end
endmodule