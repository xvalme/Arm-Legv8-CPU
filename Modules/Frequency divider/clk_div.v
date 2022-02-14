module clk_div #(parameter N = 5)(
	input wire clk,
	output wire clk_out);
	
reg counter	[N-1:0] = 0;

assign clk_out = counter[N-1];

always @(posedge(clk)) begin
	counter <= counter + 1;
end

	
endmodule