`include "Ram.v"

module tb();

reg [63:0] address, data;
reg read, write;
wire [63:0] out;

ram test (address, read, write, data, out);

initial begin

#1  read = 1;
	address = 'b0;

#1 $display ("ADDRESS: %d  DATA: %b", address, out);

//Writting

	read = 0;
	write = 1;
	data = 'd5;

#1 $display ("ADDRESS: %d  DATA: %b", address, out);

	data = 'd684;
	address = 'd1;

#1 $display ("ADDRESS: %d  DATA: %b", address, out);

	address = 'd0;
	write = 0;
	read = 1;

#1 $display ("ADDRESS: %d  DATA: %b", address, out);

end

endmodule