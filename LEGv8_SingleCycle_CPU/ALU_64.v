//64 bit Alu
module ALU_64 (ALUctr, A, B, Out, Zero);

input reg [63:0] A, B;
input [3:0] ALUctr; //Instruction set with 4 bits
output Zero;
output [63:0] Out; //Result is 64 bit 

always @* () begin 

	case (ALUctr)
		
		0: Out <= A & B;
		1: Out <= A | B;
		2: Out <= A + B;
		6: Out <= A - B;
		7: Out <= A < B ? 1 : 0;
		12: Out <= ~(A | B) //NOR;
		default: Out <= 0;
	
	endcase
end

end