//The 32 registers are declared here. 
//Writting and reading in the same clock is ok, 
//but the written register will have the old value

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

output reg [63:0] regs [31:0];

initial begin 

	//Register 31 goes to 0 just like the guidelines.
	//Others will just get filled with trash
	regs [31] <= 0;
	regs[0] <= 0;
	
end

always @(posedge(clock)) begin

	read_1 = regs [add1];
	read_2 = regs [add2];
	
end

always @(negedge(clock)) begin
	if (write_en) begin
		regs[write_add] = write_data;
	end
end

endmodule