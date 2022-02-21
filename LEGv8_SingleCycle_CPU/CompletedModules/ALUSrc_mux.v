module alusrc_mux (

	input [63:0] reg2, address;
	input alusrc;
	output reg [63:0] out;

);

always @* begin 

	if (alusrc == 0) out <= reg2;
	else out <= address;

end

endmodule