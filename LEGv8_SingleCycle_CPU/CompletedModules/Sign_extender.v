//Sign extender that takes a 32 bit value
//and extends the MSB up to 64 bit

module sign_extender (

	input wire [31:0] in,
	output reg [63:0] out

);

always @* begin
	//It basically picks the important information and sign extends
	//it using the MSB. The informations that are extended here are only
  //the addresses 

      if (in[31:26] == 6'b000101) begin // Branch. We take only the 26 bits
        out[25:0] <= in[25:0];
        out[63:26] <= {64{out[25]}};

      end else if (in[31:24] == 8'b10110100) begin // CBZ. 20 bits only of destination
        out[19:0] <= in[23:5];
        out[63:20] <= {64{out[19]}};

      end else begin // D type. 
        out[9:0] <= in[20:12];
        out[63:10] <= {64{out[9]}};
      end
	
end

endmodule