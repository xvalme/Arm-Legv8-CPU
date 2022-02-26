//Program counter with jump function

module pc (input wire clock, 
	input wire [63:0] jump,
	input wire en_jump,
	output reg [63:0] counter);

initial begin
	counter = 0;
end

always @(negedge(clock)) begin 

	if (en_jump == 1) begin 

		counter <= jump + 1;
	end
	
	else begin

		counter <= counter + 1;

	end

end

endmodule
