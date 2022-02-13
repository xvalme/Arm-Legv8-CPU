module init (input wire clk, output ini);

reg ini = 0; //For synthesization only. When in FPGA is always initalizated as 0.

always @(posedge(clk))
	ini <= 1;

endmodule