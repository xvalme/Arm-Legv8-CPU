//Implements a shift register of N bits
//4 functions: SR (01), SL(10), Load(00) and Reset(11) with enable

module shift #(parameter N = 5)(

	input clk,
	input enable,
	input right_in,
	input left_in,
	input [N-1:0] loadin,
	input [1:0] working_mode, //FUNCTION IS A RESERVED KEYWORD. Wasted 2 hours to find that out
	output reg [N-1:0] data //NO COMMA AT THE END OR BOOM
);

always @(posedge (clk)) begin

	if (enable == 1) begin

		if (working_mode == 2'd0)

			data <= loadin;

		if (working_mode == 2'b01)

			//Shift right
			//Removes the least significant bit and adds left_in as MSB
			data <= {left_in, data[N-1:1]};

		if (working_mode == 2'b10) 

			//SL
			//Removes MSB and adds a new LSB

			data <= {data[N-2:0], right_in};

		else

			//Reset
			data <= 0;

	end 

	else

		//Disabled
		data <= data;

end

endmodule
