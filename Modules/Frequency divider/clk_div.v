module clk_div(
	input wire clk,
	output wire clk_out);
	
parameter N = 5;
	
reg [N-1:0] counter= 0;

assign clk_out = counter[N-1];

always @(posedge(clk)) begin
	counter <= counter + 1;
end

	
endmodule