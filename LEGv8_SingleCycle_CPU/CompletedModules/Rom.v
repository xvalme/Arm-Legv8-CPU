//ROM for the instructions

module rom (
	input [63:0] counter,
	output reg [31:0] instruction 
);

reg [31:0] instructions [31:0];

initial begin //Function loader.
	//It seems that $readmemh works on synthetis for Xilinx (?)
	$readmemb ("instructions.txt", instructions);

end

always @* begin

	instruction <= instructions [counter];

end

endmodule