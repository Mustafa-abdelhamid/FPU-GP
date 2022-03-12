module Exponent_shifter(
	input wire [7:0] Mux_Out,
	input wire ovf_rnd,
    input wire [4:0] L_shift_value, 
    input wire  selection,
	input [1:0] L_or_R,
    output reg [7:0]  E_exponent_shifter,
	output	wire max_exponent_z
    );

//assignments
	assign max_exponent_z= &E_exponent_shifter;

//internal signals
reg [4:0]tot_shift;	
reg [8:0] E_exponent_shifter_internal;

always@(*) 
	begin
			if(selection) //left path is chosen. 
				begin
					if(L_shift_value >= ovf_rnd)
						begin
							tot_shift = L_shift_value - ovf_rnd;
							E_exponent_shifter_internal = Mux_Out -  tot_shift; // left shift    left shifter
							if(E_exponent_shifter_internal[8] == 1'b1)//underflow in exponent has been occured.
								begin
									tot_shift = 0;
									E_exponent_shifter = 8'b 000_000_00;
								end
							else
								begin
									tot_shift = 0;
									E_exponent_shifter = E_exponent_shifter_internal + ovf_rnd;
								end
						end
					else
						begin
							tot_shift = ovf_rnd - L_shift_value;
							E_exponent_shifter_internal = Mux_Out +  tot_shift;
							if(E_exponent_shifter_internal[8] == 1'b1)//overflow in exponent has been occured.
								begin
									tot_shift = 0;
									E_exponent_shifter = 8'b 111_111_11;
								end
							else
								begin
									tot_shift = 0;
									E_exponent_shifter = E_exponent_shifter_internal - ovf_rnd;	
								end
						end
				end
			else         //right path is chosen.
				begin
					case (L_or_R)
					2'b 00 :
						begin
							tot_shift = 0;
							E_exponent_shifter_internal = Mux_Out - 1 ; //left shift by one  L/R
							if(E_exponent_shifter_internal[8] == 1'b1)//underflow in exponent has been occured.
								begin
									tot_shift = 0;
									E_exponent_shifter = 8'b 000_000_00;
								end
							else
								begin
									tot_shift = 0;
									E_exponent_shifter = E_exponent_shifter_internal;
								end
						end
					2'b 01 :
						begin
							tot_shift = ovf_rnd + 1;
							E_exponent_shifter_internal = Mux_Out + tot_shift; // right shift by one  L/R
							if(E_exponent_shifter_internal[8] == 1'b1)//overflow in exponent has been occured.
								begin
									tot_shift = 0;
									E_exponent_shifter = 8'b 111_111_11;
								end
							else
								begin
									tot_shift = 0;
									E_exponent_shifter = E_exponent_shifter_internal - ovf_rnd;	
								end
						end
					default : 
						begin
							tot_shift = 0;
							E_exponent_shifter_internal = Mux_Out;
							E_exponent_shifter = E_exponent_shifter_internal ;
						end 
					endcase
				end

	end
endmodule