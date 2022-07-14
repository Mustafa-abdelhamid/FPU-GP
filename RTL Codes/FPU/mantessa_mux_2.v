module mantessa_mux_2 (choose_left , left_path , right_path , mantessa_mux_out);
input choose_left;
input [23:0]left_path ;
input [23:0]right_path; 
output reg [23:0]mantessa_mux_out;
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