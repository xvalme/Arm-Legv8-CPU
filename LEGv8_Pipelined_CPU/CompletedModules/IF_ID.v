module if_id (
	input clock,
	input wire [63:0] pc,
	input wire [31:0] instruction,

	output reg [31:0] Instruction,
	output reg [63:0] Pc
);

always @(posedge(clock)) begin
	Pc = pc;
	Instruction = instruction;
end

endmodule