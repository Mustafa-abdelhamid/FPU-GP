module mantessa_mux (
input [22:0]left_path , right_path,
input [2:0]most_bits_of_adder_out,
output reg [22:0]final_mantessa
);

assign choose_left = ~| most_bits_of_adder_out;
always@(*)
begin
    if(choose_left)
        begin
            final_mantessa = left_path;
        end
    else
        begin
            final_mantessa = right_path;
        end
end
endmodule