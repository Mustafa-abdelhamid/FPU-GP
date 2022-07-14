module round_1 (Min , inexact_flag);
input [26:0]Min;
output reg inexact_flag;
wire guard_bits;
assign guard_bits = Min[2:0];
always@(*)
begin
    inexact_flag = | guard_bits;
end
endmodule