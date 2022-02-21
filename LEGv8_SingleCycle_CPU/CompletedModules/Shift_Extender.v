//2 bit shift extender.
//Actual hardware for implementing this is not necessary. We just move the wires.

module shift_extender (input [63:0] in, output reg [63:0] out);

always @ (in) begin

	out <= {in[61:0], 2'b0};

end

endmodule