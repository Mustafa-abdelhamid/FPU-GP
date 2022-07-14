    module adder (A,B,sub,sum,carry_out);
input [26:0]A,B;
input sub;
output reg [26:0]sum;
output reg carry_out;
always@(*)
begin
    {carry_out , sum} = A + B + sub;
end
endmodule
    
