module mux_2_in_2_out_31_bits_int (in0 , in1 , sel , out0 , out1);
input [30:0]in0,in1;//{E , M}
input sel;
output reg [22:0]out0;
output reg [7:0]out1;
always@(*)
begin
    case(sel)
        1'b0:
            begin
                out0 = in0[22:0];
                out1 = in0[30:23];
            end
        1'b1:
            begin
                out0 = in1[22:0];
                out1 = in1[30:23];
            end
    endcase
end
endmodule