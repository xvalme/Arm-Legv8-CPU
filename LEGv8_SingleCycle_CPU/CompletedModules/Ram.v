//The RAM for the CPU
//Stores 64 bit information 

module ram (
	input clock,
	input [63:0] address,
	input read_en,
	input write_en,
	input [63:0] data_in, //for writting
	output reg [63:0] out
);

reg [63:0] data [31:0]; //64 bit information in 2^32 addresses.

always @ (posedge(clock)) begin
//Read or write only. If both enable are high, read has priority and will run instead

	if (read_en) begin 

		out <= data [address];

	end 

	else if (write_en) begin

		data [address] <= data_in;
		out <= data_in; 

	end

	else begin 
		//No reading nor writting
		out <= 0;

	end

end

endmodule