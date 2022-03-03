//ROM for the instructions

module rom (
	input clock,
	input [63:0] counter,
	output reg [31:0] instruction
);

reg [31:0] instructions [31:0];
integer number_of_instructions, i;

initial begin //Function loader.
	//It seems that $readmemb works on synthetis for Xilinx (?)
	$readmemb ("instructions.txt", instructions);

end

always @ (negedge(clock)) begin

	instruction <= instructions [counter];

end

endmodule