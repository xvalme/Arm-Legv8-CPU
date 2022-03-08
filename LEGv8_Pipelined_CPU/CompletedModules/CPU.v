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
//Pipeline components
`include "IF_ID.v"
`include "ID_EX.v"
`include "EX_MEM.v"
`include "MEM_WB.v"

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
pc PC (.clock(clock), .en_jump(en_jump), .jump(jump_address_ex_mem), .counter(counter));

//ROM. Computes instruction from PC.
output wire [31:0] instruction;
rom ROM (clock, counter, instruction);

//Pipeline DIVISION --------------------------------------
//IF_ID Stage

wire [31:0] Instruction_if_id;
wire [63:0] Counter_if_id;

if_id IF_ID (
	clock,
	counter,
	instruction,
	Instruction_if_id,
	Counter_if_id
);

//Reg2Loc Mux.
wire [4:0] out_reg2loc;
reg2loc_mux reg2loc_mux (Instruction_if_id[20:16], Instruction_if_id[4:0], Instruction_if_id[28], out_reg2loc);

//Registers
output wire [63:0] read1, read2;
regs regs (clock,
			Instruction_if_id[9:5], //R1
			out_reg2loc, //R2 
			write_reg_mem_wb, 
			RegWrite_mem_wb,
			write_data, 
			read1,
			read2);

//Sign extender module
wire [63:0] sign_extended_address;
sign_extender sign_extender (Instruction_if_id,sign_extended_address);

//CoNtRoLUnIT. Takes care of selecting working mode of components
wire reg2loc, ALUSrc, memtoreg, RegWrite;
wire readmem_en, writemem_en;
wire Branch, UncBranch;
wire [1:0] AluOp;

control_unit control_unit (
Instruction_if_id[31:21], reg2loc, ALUSrc, memtoreg, 
RegWrite, readmem_en, writemem_en, Branch,UncBranch, AluOp);

//Pipeline DIVISION --------------------------------------
wire [63:0] Counter_id_ex;
wire [63:0] read1_id_ex, read2_id_ex;
wire [63:0] sign_extended_address_id_ex;
wire [10:0] alu_ctrl_data;
wire [4:0] write_reg_id_ex;
wire [1:0] AluOP_id_ex;
wire ALUSrc_id_ex;
wire Branch_id_ex, UncBranch_id_ex;
wire readmem_en_id_ex, writemem_en_id_ex;
wire RegWrite_id_ex, memtoreg_id_ex;
wire [31:0] instruction_id_ex;

id_ex ID_EX (
	//Inputs:
	clock,
	read1,
	read2,
	sign_extended_address,
	Instruction_if_id,
	AluOp,
	ALUSrc,
	Branch,
	UncBranch,
	readmem_en,
	writemem_en,
	RegWrite,
	memtoreg,
	Counter_if_id,
	//Outputs
	Counter_id_ex,
	read1_id_ex,
	read2_id_ex,
	sign_extended_address_id_ex,
	alu_ctrl_data,
	write_reg_id_ex,
	AluOP_id_ex,
	ALUSrc_id_ex,
	Branch_id_ex,
	UncBranch_id_ex,
	readmem_en_id_ex,
	writemem_en_id_ex,
 	RegWrite_id_ex, 
	memtoreg_id_ex,
	instruction_id_ex
);

//ALUSrc mux
wire [63:0] out_ALUSrc;
alusrc_mux alusrc_mux (read2_id_ex, sign_extended_address_id_ex, ALUSrc_id_ex, out_ALUSrc);

//ALU 
wire Zero;
output wire [63:0] ALU_out;
alu ALU (ALUCtrl, read1_id_ex, out_ALUSrc, ALU_out, Zero);

//ALUCtrl
wire [3:0] ALUCtrl; //Alu Code to select working function
aluctrl Aluctrl (AluOP_id_ex, alu_ctrl_data, ALUCtrl);

//ALU that works as an Adder for the jumping address.
wire [63:0] jump_address;
alu JumpAdder (4'd2, Counter_id_ex, sign_extended_address_id_ex, jump_address,);

//Pipeline DIVISION --------------------------------------
wire Zero_ex_mem;
wire [63:0] ALU_out_ex_mem;
wire [63:0] jump_address_ex_mem;
wire [63:0] read2_ex_mem;
wire [4:0] write_reg_ex_mem;
wire Branch_ex_mem, UncBranch_ex_mem;
wire readmem_en_ex_mem, writemem_en_ex_mem;
wire RegWrite_ex_mem, memtoreg_ex_mem;
wire [31:0] instruction_ex_mem;

ex_mem EX_MEM (
	clock,
	instruction_id_ex,
	jump_address,
	ALU_out,
	Zero,
	read2_id_ex,
	write_reg_id_ex,
	Branch_id_ex,
	UncBranch_id_ex,
	readmem_en_id_ex,
	writemem_en_id_ex,
	RegWrite_id_ex, 
	memtoreg_id_ex,
	//Outputs:
	jump_address_ex_mem,
	ALU_out_ex_mem,
	Zero_ex_mem,
	read2_ex_mem,
	write_reg_ex_mem,
	Branch_ex_mem,
	UncBranch_ex_mem,
	readmem_en_ex_mem,
	writemem_en_ex_mem,
 	RegWrite_ex_mem, 
	memtoreg_ex_mem,
	instruction_ex_mem

);

//Data Memory
output wire [63:0] mem_data;
ram ram (ALU_out_ex_mem, readmem_en_ex_mem, writemem_en_ex_mem, read2_ex_mem, mem_data);

wire en_jump = (Branch_ex_mem & Zero_ex_mem) | UncBranch_ex_mem;

//Pipeline DIVISION --------------------------------------
wire [63:0] mem_data_mem_wb;
wire [63:0] ALU_out_mem_wb;
wire [4:0] write_reg_mem_wb;
wire RegWrite_mem_wb, memtoreg_mem_wb;
wire [31:0] instruction_mem_wb;

mem_wb MEM_WB (
	clock,
	mem_data,
	ALU_out_ex_mem,
	write_reg_ex_mem,
	instruction_ex_mem,
	RegWrite_ex_mem,
	memtoreg_ex_mem,
	//Outputs
	instruction_mem_wb,
	mem_data_mem_wb,
	ALU_out_mem_wb,
	write_reg_mem_wb,
	RegWrite_mem_wb, 
	memtoreg_mem_wb
);

//Memtoreg Mux at the end of memory 
wire [63:0] write_data;
memtoreg_mux memtoreg_mux (ALU_out_mem_wb, mem_data_mem_wb, memtoreg_mem_wb, write_data);

endmodule