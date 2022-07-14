module adder_modified_new (A,B,sub,sum,ovf_out);
input [26:0]A,B;
input sub;
output wire [26:0]sum;
output wire ovf_out;
//internal signals
wire carry_out;
//instances
adder adder_inst (A,B,sub,sum,carry_out);
ovf_block ovf_block_inst (carry_out , sub , ovf_out);
endmodule