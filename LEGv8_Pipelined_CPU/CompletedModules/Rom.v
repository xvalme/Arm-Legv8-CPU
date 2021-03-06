//ROM for the instructions

module rom (
	input clock,
	input [63:0] counter,
	output reg [31:0] instruction 
);

reg [31:0] instructions [31:0];

initial begin //Function loader.
	//It seems that $readmemb works on synthetis for Xilinx (?)
	$readmemb ("instructions.txt", instructions);

end

always @ (posedge(clock)) begin

	instruction <= instructions [counter];

end

endmodule