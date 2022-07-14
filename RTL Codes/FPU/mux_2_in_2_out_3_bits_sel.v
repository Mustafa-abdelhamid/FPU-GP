module mux_2_in_2_out_3_bits_sel (in0 , in1 , sel , out0 , out1);
input [24:0]in0 , in1;//{ovf_rnd , Mout}
input [2:0]sel;
output reg [23:0]out0;//Mout
output reg out1;//ovf_rnd
always@(*)
begin
    case(sel)
        3'b000:
            begin
                out0 = in0[23:0];
                out1 = in0[24];
            end
        default:
            begin
                out0 = in1[23:0];
                out1 = in1[24];
            end
    endcase
end
endmodule