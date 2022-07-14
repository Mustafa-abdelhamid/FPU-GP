    module LZA_1_modified (A,B,E);
input [26:0]A,B;
output reg [26:0]E;
always@(*)
    begin
		if((A == 27'b 0000_0000_0000_0000_0000_0000_000) && (B == 27'b 0000_0000_0000_0000_0000_0000_000))
			begin
				E = 27'b 0000_0000_0000_0000_0000_0000_000; 
			end
		else
			begin
				E[0] = 1'b1;
				E[1] = (A[1]~^B[1]) & (A[0]|B[0]);
				E[2] = (A[2]~^B[2]) & (A[1]|B[1]);
				E[3] = (A[3]~^B[3]) & (A[2]|B[2]);
				E[4] = (A[4]~^B[4]) & (A[3]|B[3]);
				E[5] = (A[5]~^B[5]) & (A[4]|B[4]);
				E[6] = (A[6]~^B[6]) & (A[5]|B[5]);
				E[7] = (A[7]~^B[7]) & (A[6]|B[6]);
				E[8] = (A[8]~^B[8]) & (A[7]|B[7]);
				E[9] = (A[9]~^B[9]) & (A[8]|B[8]);
				E[10] = (A[10]~^B[10]) & (A[9]|B[9]);
				E[11] = (A[11]~^B[11]) & (A[10]|B[10]);
				E[12] = (A[12]~^B[12]) & (A[11]|B[11]);
				E[13] = (A[13]~^B[13]) & (A[12]|B[12]);
				E[14] = (A[14]~^B[14]) & (A[13]|B[13]);
				E[15] = (A[15]~^B[15]) & (A[14]|B[14]);
				E[16] = (A[16]~^B[16]) & (A[15]|B[15]);
				E[17] = (A[17]~^B[17]) & (A[16]|B[16]);
				E[18] = (A[18]~^B[18]) & (A[17]|B[17]);
				E[19] = (A[19]~^B[19]) & (A[18]|B[18]);
				E[20] = (A[20]~^B[20]) & (A[19]|B[19]);
				E[21] = (A[21]~^B[21]) & (A[20]|B[20]);
				E[22] = (A[22]~^B[22]) & (A[21]|B[21]);
				E[23] = (A[23]~^B[23]) & (A[22]|B[22]);
				E[24] = (A[24]~^B[24]) & (A[23]|B[23]);
				E[25] = (A[25]~^B[25]) & (A[24]|B[24]);
				E[26] = (A[26]~^B[26]) & (A[25]|B[25]);
			end
		  end
		  endmodule
    