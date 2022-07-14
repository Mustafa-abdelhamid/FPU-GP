module ROUND # (
parameter	Significant_WD = 23 ,
parameter	roundmodeReg_WD=2   
)
////////////////////////////////////////////////////////////
//////////// Input and output port decleration /////////////
////////////////////////////////////////////////////////////
(
input	wire 	[Significant_WD+3:0] Min   ,  //operands significand in + 3 guard bits
input	wire	[roundmodeReg_WD-1:0] roundMode,
		
input		Sign_in ,
output	reg		[Significant_WD:0] MOut  , //24 bits
output	reg				ovf_rnd,inexact_flag 
) ;
parameter	toNearest	= 2'b 00 ,
			toZero 		= 2'b 01 ,
			toPinf		= 2'b 10 , //to plus inf
			toMinf		= 2'b 11 ; //to minus inf	

////////////////////////////////////////////////////////////
//////////////////////Internal signals//////////////////////
////////////////////////////////////////////////////////////
wire [2:0] guard_bits ;
reg hidden ;
reg [22:0]internal_mantessa; //23bits
assign guard_bits=Min[2:0] ; 
////////////////////////////////////////////////////////////
////////////////////////  behaviour ////////////////////////
////////////////////////////////////////////////////////////
always@ (*)
	begin
		inexact_flag = | guard_bits ; 
		ovf_rnd= 1'b0 ;
		hidden = 1;
		case (roundMode)
		
		toNearest:
			begin
				case(guard_bits)
				3'b 000 :
					begin
						internal_mantessa=Min[Significant_WD+2:3] ;
						MOut = {1'b1 , internal_mantessa};
						hidden = 1;
					end
				3'b 001 :
					begin
						internal_mantessa=Min[Significant_WD+2:3] ;
						MOut = {1'b1 , internal_mantessa};
						hidden = 1;
					end
				3'b 010 :
					begin
						internal_mantessa=Min[Significant_WD+2:3] ;
						MOut = {1'b1 , internal_mantessa};
						hidden = 1;
					end
				3'b 011 :
					begin
						internal_mantessa=Min[Significant_WD+2:3] ;
						MOut = {1'b1 , internal_mantessa};
						hidden = 1;
					end
				3'b 100 :
					begin
						if (Min[3])
							begin
							{ovf_rnd,hidden,internal_mantessa}=Min[Significant_WD+3:3] + 1'b1 ;
							if(ovf_rnd)
								begin
									MOut = {1'b1 , hidden , internal_mantessa[22:1]};	
								end
							else
								begin
									MOut = {hidden , internal_mantessa};
								end
							end
						else 
							begin
							internal_mantessa=Min[Significant_WD+2:3] ;
							MOut = {Min[26] , internal_mantessa};
							end
					end
				3'b 101 :
					begin
						{ovf_rnd,hidden,internal_mantessa}=Min[Significant_WD+3:3] + 1'b1 ;
						if(ovf_rnd)
							begin
								MOut = {1'b1 , hidden , internal_mantessa[22:1]};	
							end
						else
							begin
								MOut = {hidden , internal_mantessa};
							end
					end
				3'b 110 :
					begin
						{ovf_rnd,hidden,internal_mantessa}=Min[Significant_WD+3:3] + 1'b1 ;
						if(ovf_rnd)
							begin
								MOut = {1'b1 , hidden , internal_mantessa[22:1]};	
							end
						else
							begin
								MOut = {hidden , internal_mantessa};
							end
					end
				3'b 111 :
					begin
						{ovf_rnd,hidden,internal_mantessa}=Min[Significant_WD+3:3] + 1'b1 ;
						if(ovf_rnd)
							begin
								MOut = {1'b1 , hidden , internal_mantessa[22:1]};	
							end
						else
							begin
								MOut = {hidden , internal_mantessa};
							end
					end
				endcase
			end
		toZero : 
			begin
				internal_mantessa=Min[Significant_WD+2:3] ;
				MOut = {Min[26] , internal_mantessa};
			end
		
		toPinf:
			begin
				if (Sign_in)
					begin
					internal_mantessa=Min[Significant_WD+2:3] ;
					MOut = {Min[26] , internal_mantessa};
					end
				else
					begin
						
						case(guard_bits)
							3'b 000:
								begin
								 internal_mantessa=Min[Significant_WD+2:3] ;
								 MOut = {Min[26] , internal_mantessa};
								end
							default:
								begin
								{ovf_rnd,hidden,internal_mantessa}=Min[Significant_WD+3:3] + 1'b1 ;
								if(ovf_rnd)
									begin
										MOut = {1'b1 , hidden , internal_mantessa[22:1]};	
									end
								else
									begin
										MOut = {hidden , internal_mantessa};
									end
								end
						endcase
					end
			end
		toMinf:
			begin
				if (Sign_in==1'b0)
					begin
						internal_mantessa=Min[Significant_WD+2:3] ;
						MOut = {1'b1 , internal_mantessa};
						hidden = 1;
					end
				else
					begin
						
						case(guard_bits)
							3'b 000:
								begin
								 internal_mantessa=Min[Significant_WD+2:3] ;
								 MOut = {1'b1 , internal_mantessa};
								 hidden = 1;
								end
							default:
								begin
								{ovf_rnd,hidden,internal_mantessa}=Min[Significant_WD+3:3] + 1'b1 ;
								if(ovf_rnd)
									begin
										MOut = {1'b1 , hidden , internal_mantessa[22:1]};	
									end
								else
									begin
										MOut = {hidden , internal_mantessa};
									end
								end
						endcase
					end
				
			end
			
		endcase
	end

endmodule