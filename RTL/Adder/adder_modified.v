module adder_modified (A,B,sub,sum,ovf_out);
input [26:0]A,B;
input sub;
output reg [26:0]sum;
output reg ovf_out;
reg carry_out;
always@(*)
begin
	{carry_out,sum} = A + B + sub;
	ovf_out = carry_out & ~sub;
end
endmodule