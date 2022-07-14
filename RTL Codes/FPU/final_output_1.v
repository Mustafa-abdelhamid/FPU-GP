module final_output_1 (mantessa_mux_out , excessive_shift_left , final_M_out);
input [23:0]mantessa_mux_out;
input [9:0]excessive_shift_left;
output reg [22:0]final_M_out;
always@(*)
begin
    final_M_out = mantessa_mux_out >> excessive_shift_left;
end
endmodule