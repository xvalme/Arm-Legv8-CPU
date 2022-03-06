`include "PC.v"
`include "Rom.v"
`include "Regs.v"
`include "Reg2loc_mux.v"
`include "MemtoReg_mux.v"
`include "ALU_64.v"
`include "Ram.v"
`include "Aluctrl.v"
`include "ALUSrc_mux.v"
`include "control_unit.v"
`include "Sign_extender.v"

module cpu (
	clock,
	//For testing:
	counter,
	instruction, 
	read1,
	read2,
	ALU_out,
	mem_data
);

input wire clock;

//Program Counter. It already has a jump feature.
output wire [63:0] counter;
pc PC (.clock(clock), .en_jump(en_jump), .jump(jump_address), .counter(counter));

//ROM. Computes instruction from PC.
output wire [31:0] instruction;
rom ROM (clock, counter, instruction);

//Reg2Loc Mux.
wire [4:0] out_reg2loc;
reg2loc_mux reg2loc_mux (instruction[20:16], instruction[4:0], reg2loc, out_reg2loc);

//Registers
output wire [63:0] read1, read2;
regs regs (clock,
			instruction[9:5], 
			out_reg2loc,
			instruction[4:0],
			RegWrite, 
			write_data, 
			read1,
			read2);
			
//ALUSrc mux
wire [63:0] out_ALUSrc;
alusrc_mux alusrc_mux (read2, sign_extended_address, ALUSrc, out_ALUSrc);

//ALU 
wire Zero;
output wire [63:0] ALU_out;
alu ALU (ALUCtrl, read1, out_ALUSrc, ALU_out, Zero);

//ALUCtrl
wire [3:0] ALUCtrl; //Alu Code to select working function
aluctrl aluctrl (AluOp, instruction[31:21], ALUCtrl);

//Data Memory
output wire [63:0] mem_data;
ram ram (ALU_out, readmem_en, writemem_en, read2, mem_data);

//Memtoreg Mux at the end of memory 
wire [63:0] write_data;
memtoreg_mux memtoreg_mux (ALU_out, mem_data, memtoreg, write_data);

//CoNtRoLUnIT. Takes care of selecting working mode of components
wire reg2loc, ALUSrc, memtoreg, RegWrite;
wire readmem_en, writemem_en;
wire Branch, UncBranch;
wire [1:0] AluOp;

control_unit control_unit (
instruction[31:21], reg2loc, ALUSrc, memtoreg, 
RegWrite, readmem_en, writemem_en, Branch,UncBranch, AluOp);

wire en_jump = (Branch & Zero) | UncBranch;

//ALU that works as an Adder for the jumping address.
wire [63:0] jump_address;
alu JumpAdder (4'd2, counter, sign_extended_address, jump_address,);

//Sign extender module
wire [63:0] sign_extended_address;
sign_extender sign_extender (instruction,sign_extended_address);

//Shift extender that picks up the sign extended address to send to PC
//NOT USED HERE SINCE WE CONSIDER THE WORDS TO BE 32 BIT LONG
/*
wire [63:0] shifted_add;
shift_extender shift_extender (sign_extended_address, shifted_add);
*/
endmodule