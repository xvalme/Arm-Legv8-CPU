//Mux at the end of the memory

module memtoreg_mux (

	input [63:0] result, data;
	input src;
	output reg [63:0] out;

);

always @* begin 

	if (src == 0) out <= result;
	else out <= data;

end

endmodule