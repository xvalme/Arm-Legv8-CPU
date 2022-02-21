`include "Rom.v"
`include "PC.v" 

module tb();

wire [31:0] counter;
wire [31:0] inst;
reg clk = 0;
wire en_jump = 0;
wire [31:0] jump = 'b0;

pc c (clk, jump, en_jump, counter);
rom test (counter, inst);

always #1 clk = ~clk;

initial begin
	
	clk = 0;

	#1
	$display ("Instruction Nº: %d CODE: %b", counter, inst);

	#2
	$display ("Instruction Nº: %d CODE: %b", counter, inst);

	#2
	$display ("Instruction Nº: %d CODE: %b", counter, inst);

	$finish;

end

endmodule