//Sign extender that takes a 32 bit value
//and extends the MSB up to 64 bit

module sign_extender (

	input wire [31:0] in,
	output reg [63:0] out

);

always @ (in) begin

	out [31:0] <= in;
	
	for (integer i = 32; i < 64; i++) out[i] = in[31];
	
end

endmodule