module adder_modified (
input [26:0]A,B,
input sub,
output reg [26:0]sum,
output reg ovf_out,
output reg [2:0] most_bits_of_adder_out

);

reg carry_out;
always@(*)
begin
	{carry_out,sum} = A + B + sub;
	ovf_out = carry_out & ~sub;
	most_bits_of_adder_out={ovf_out , sum[26:25]};
end
endmodule