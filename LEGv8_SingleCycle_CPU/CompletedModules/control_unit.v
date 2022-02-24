module control_unit (Instruction,
Reg2Loc, 
ALUSrc, 
MemtoReg, 
RegWrite,
MemRead,
MemWrite,
Branch, 
AluOp);

input wire [10:0] Instruction;
output reg Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch;
output reg [1:0] AluOp;

always @* begin 

	case (Instruction)
	
		'b11111000010: begin //LDUR
		
			Reg2Loc <= 0;
			ALUSrc <= 1;
			MemtoReg <= 1;
			RegWrite <= 1;
			MemRead <= 1;
			MemWrite <= 0;
			Branch <= 0;
			AluOp <= 'b00;
			
		end
		
		'b11111000000: begin //STUR
		
			Reg2Loc <= 1;
			ALUSrc <= 1;
			MemtoReg <= 1;
			RegWrite <= 0;
			MemRead <= 0;
			MemWrite <= 1;
			Branch <= 0;
			AluOp <= 'b00;
			
		end
		
		'b10110100xxx: begin  //CBZ
		
			Reg2Loc <= 1;
			ALUSrc <= 0;
			MemtoReg <= 0;
			RegWrite <= 0;
			MemRead <= 0;
			MemWrite <= 1;
			Branch <= 0;
			AluOp <= 'b01;
			
		end
		
		'b1xx0101x000: begin //R Type
		
			Reg2Loc <= 0;
			ALUSrc <= 0;
			MemtoReg <= 0;
			RegWrite <= 1;
			MemRead <= 0;
			MemWrite <= 0;
			Branch <= 0;
			AluOp <= 'b10;
			
		end
		
		default: begin
				Reg2Loc <= 0;
				ALUSrc <= 0;
				MemtoReg <= 0;
				RegWrite <= 0;
				MemRead <= 0;
				MemWrite <= 0;
				Branch <= 0;
				AluOp <= 0;
		end

	endcase
	
end
endmodule