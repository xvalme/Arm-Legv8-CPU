`include "initializator.v"

module tb();

reg clk = 0; //input
wire ini; //ouput 

init test (.clk(clk),
		.ini(ini));

//generating the clk:
always #2 clk = ~clk; 

initial begin

$dumpfile("init_tb.vcd");
$dumpvars;

#20 $finish;

end

endmodule