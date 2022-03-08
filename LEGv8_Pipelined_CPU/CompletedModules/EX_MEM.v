module ex_mem (
	input clock,
	input wire [31:0] Instruction; //Just for testing
	//Data for later
	input wire [63:0] add_result,
	input wire [63:0] alu_result,
	input wire zero,
	input wire [63:0] read2,
	input wire [4:0] write_reg,
	
	//Mem
	input wire branch,
	input wire uncBranch,
	input wire memread,
	input wire memwrite,
	//WB
	input wire regWrite,
	input wire memtoReg,

	//Outputs
	output reg [63:0] Add_result,
	output reg [63:0] Alu_result,
	output reg Zero,
	output reg [63:0] Read2,
	output reg [4:0] Write_reg,
	//Mem
	output reg Branch,
	output reg UncBranch,
	output reg Memread,
	output reg Memwrite,
	//WB
	output reg RegWrite,
	output reg MemtoReg

);

always @(posedge(clock)) begin

	Add_result = add_result;
	Alu_result = alu_result;
	Zero = zero;
	Read2 = read2;
	Write_reg = write_reg;
	Branch = branch;
	Memread = memread;
	Memwrite = memwrite;
	RegWrite = regWrite;
	MemtoReg = memtoReg;
	UncBranch = uncBranch;

end

endmodule
