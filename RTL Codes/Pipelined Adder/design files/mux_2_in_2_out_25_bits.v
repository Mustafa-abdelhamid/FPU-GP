module mux_2_in_2_out_25_bits (in0 , in1 , sel , out0 , out1);
input [24:0]in0,in1;//{ovf_rnd , Mout}
input sel;
output reg [23:0]out0;//Mout
output reg out1;//ovf_rnd
always@(*)
begin
    case(sel)
        1'b0:
            begin
                out0 = in0[23:0];
                out1 = in0[24];
            end
        1'b1:
            begin
                out0 = in1[23:0];
                out1 = in1[24];
            end
    endcase
end
endmodule