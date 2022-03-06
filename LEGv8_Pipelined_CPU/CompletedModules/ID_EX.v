module id_ex (
	input clock,
	//Data for later
	input wire [31:0] read1,
	input wire [31:0] read2,
	input wire [63:0] sign_extended,
	input wire [31:0] instruction, 
	//Ex
	input wire [1:0] aluOp,
	input wire aluSrc,
	//Mem
	input wire branch,
	input wire memread,
	input wire memwrite,
	//WB
	input wire regWrite,
	input wire memtoReg,
	//PC
	input wire [63:0] pc,

	//Outputs
	output reg [63:0] Pc,
	output reg [31:0] Read1,
	output reg [31:0] Read2,
	output reg [63:0] Sign_extended,
	output reg [10:0] alu_ctrl_data,
	output reg [5:0] write_reg,
	//Ex
	output reg [1:0] AluOp,
	output reg ALUSrc,
	//Mem
	output reg Branch,
	output reg Memread,
	output reg Memwrite,
	//WB
	output reg RegWrite,
	output reg MemtoReg

);


always @(posedge(clock)) begin

	alu_ctrl_data = instruction [31:21];
	write_reg = instruction[4:0];
	Read1 = read1;
	Read2 = read2;
	Sign_extended = sign_extended;
	Pc = pc;
	AluOp = aluOp;
	ALUSrc = aluSrc;
	Branch = branch;
	Memread = memread;
	Memwrite = memwrite;
	RegWrite = regWrite;
	MemtoReg = memtoReg;

end

endmodule