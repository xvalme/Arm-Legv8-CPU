//Program counter with jump function

module pc (input wire clock, 
	input wire jump[31:0],
	input wire en_jump,
	output reg [31:0] counter);

always (posedge(clk)) begin 

	if (en_jump == 1) begin 

		counter <= jump;

	end

	else begin

		counter <= counter + 1;

	end

end

endmodule
