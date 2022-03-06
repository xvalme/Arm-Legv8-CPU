//Mux at the end of the memory

module memtoreg_mux (

	input [63:0] ALU_result,
	input [63:0] data,
	input src,
	output reg [63:0] out

);

always @* begin 

	if (src == 0) out <= ALU_result;
	else out <= data;

end

endmodule