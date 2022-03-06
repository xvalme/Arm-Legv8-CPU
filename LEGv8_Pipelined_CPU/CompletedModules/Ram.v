//The RAM for the CPU
//Stores 64 bit information 

module ram (
	input [63:0] address,
	input read_en,
	input write_en,
	input [63:0] data_in, //for writting
	output reg [63:0] out
);

reg [63:0] data [31:0]; //64 bit information in 32 addresses.

integer initCount;
integer u;

initial begin //Filling with values
    for (initCount = 0; initCount < 32; initCount = initCount + 1) begin
      data[initCount] = initCount * 100;
	end
end
	
//Read or write only. If both enable are high, write has priority and will run instead
//This is a latch since not all values of if - else are written.

always @* begin
	if (write_en) begin 

		data [address] <= data_in;

	end 

	if (read_en) begin

		out <= data [address];

	end
	
	/*For testing
	$display("-----");
	for (u = 0; u<32; u = u + 1) $display("%d: %d", u, data [u]);
	*/
end

endmodule