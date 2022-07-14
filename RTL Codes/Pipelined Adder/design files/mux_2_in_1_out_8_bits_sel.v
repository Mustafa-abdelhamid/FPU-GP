module mux_2_in_1_out_8_bits_sel (in0 , in1 , sel , out);
input [26:0]in0 , in1;
input [7:0]sel;
output reg [26:0]out;
always@(*)
begin
    case(sel)
        8'b 0000_0000:
            begin
                out = in0;
            end
        default:
            begin
                out = in1;
            end
    endcase
end
endmodule