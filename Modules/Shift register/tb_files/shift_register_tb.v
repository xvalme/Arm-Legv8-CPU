`include "shift_register.v"

module tb();

parameter N = 5;

reg clk = 0;
reg enable = 0;
reg right_in = 0;
reg left_in = 0;
reg [N-1:0] loadin = 0; //name goes after the array size
reg [1:0] working_mode = 0;
wire [N-1:0] data;

always #1 clk = ~clk;

//UUT:

shift test (
	.clk(clk),
	.enable(enable),
	.right_in(right_in),
	.left_in(left_in),
	.loadin(loadin),
	.working_mode(working_mode),
	.data(data)
);

initial begin 

$dumpfile("test_output.vcd");
$dumpvars;

#1 $display("Simulation started. Current data: %b", data);
enable = 1;
#1 $display("[ENABLE TEST] Current data: %b", data);
working_mode = 2'd0;
loadin = 'b10011;
#2 $display("[LOAD TEST of 10011] Current data: %b", data);
working_mode = 2'b01;
left_in = 1;
#2 $display("[SR of 1] Current data: %b", data);
#1 $display ("[SR of 1 again] Current data: %b", data);
working_mode=2'b10;
right_in = 0;
#2 $display ("[SL of 0] Current data: %b", data);
right_in = 1;
#2 $display ("[SL of 1] Current data: %b", data);
working_mode = 2'b11;
#2 $display ("[Reset] Current data: %b", data);

$finish;

end

endmodule