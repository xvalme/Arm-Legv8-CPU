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
integer i;
integer u;

initial begin 

	//Register 31 goes to 0 just like the guidelines.
	regs [31] <= 0;
	
	//Giving values to registers from 0 up to 30
	for (i = 0; i<31; i = i + 1) begin
		regs[i] <= i;
	end

end

always @(posedge(clock)) begin

	read_1 = regs [add1];
	read_2 = regs [add2];
	
end

always @(negedge(clock)) begin
	if (write_en) begin
		regs[write_add] = write_data;
	end
	

	$display("-----");
	for (u = 0; u<32; u = u + 1) $display("Reg %d: %d", u, regs [u]);

end

endmodule