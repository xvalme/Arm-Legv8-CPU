`include "shift_register.v"

module tb();

parameter N = 5;

reg clk = 0;
wire enable = 0;
wire right_in = 0;
wire left_in = 0;
wire loadin [N-1:0];
wire working_mode [1:0];
wire [N-1:0] data;

//UUT:

shift test (
	clk,
	enable,
	right_in,
	left_in,
	loadin[N-1:0],
	working_mode[1:0],
	data[N-1:0]
);

endmodule