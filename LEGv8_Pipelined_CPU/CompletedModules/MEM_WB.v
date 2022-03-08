module mem_wb (
	input clock,
	//Data for later
	input wire [63:0] read_data,
	input wire [63:0] alu_result,
	input wire [4:0] write_reg,
	input wire [31:0] instruction; //Just for testing
	//WB
	input wire regWrite,
	input wire memtoReg,

	//Outputs
	output reg [31:0] Instruction;
	
	output reg [63:0] Read_data,
	output reg [63:0] Alu_result,
	output reg [4:0] Write_reg,
	//WB
	output reg RegWrite,
	output reg MemtoReg
	

);

always @(posedge(clock)) begin

	Instruction = instruction;
	Read_data = read_data;
	Alu_result = alu_result;
	Write_reg = write_reg;
	RegWrite = regWrite;
	MemtoReg = memtoReg;

end

endmodule
