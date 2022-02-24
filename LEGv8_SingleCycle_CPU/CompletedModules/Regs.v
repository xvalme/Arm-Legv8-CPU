//The 32 registers are declared here. 
//Writting and reading in the same clock is ok, but the written register will have the old value (obviously)

module regs (

	input clock,
	input [4:0] add1,
	input [4:0] add2,
	input [4:0] write_add,

	input write_en,
	input [63:0] write_data,

	output reg [63:0] read_1, 
	output reg [63:0] read_2

);

reg [63:0] regs [31:0];

initial begin 

	//Register 31 goes to 0 just like the guidelines.
	regs [31] <= 0;
	
	//Register 1 goes to 1 for testing.
	regs [1] <= 1;

end

always @ (posedge(clock)) begin

	read_1 <= regs [add1];
	read_2 <= regs [add2];

	if (write_en) regs[write_add] <= write_data;
	else regs[write_add] <= regs[write_add];

end

endmodule