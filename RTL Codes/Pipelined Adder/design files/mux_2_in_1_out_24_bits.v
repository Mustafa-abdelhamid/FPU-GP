module mux_2_in_1_out_24_bits (in0 , in1 , sel , out);
input [23:0]in0 , in1;
input sel;
output reg [23:0]out;
always@(*)
begin
    case(sel)
        1'b0:
            begin
                out = in0;
            end
        1'b1:
            begin
                out = in1;
            end 
    endcase   
end
endmodule