module first_massive_shift_left (adder_out , SHL , sum_shifted);
input [26:0]adder_out;
input [4:0]SHL;
output reg [26:0]sum_shifted;
always@(*)
begin
    sum_shifted = adder_out << SHL;
end
endmodule