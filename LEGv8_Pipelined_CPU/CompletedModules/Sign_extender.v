//Sign extender that takes a 32 bit value
//and extends the MSB up to 64 bit

module sign_extender (

	input wire [31:0] in,
	output reg [63:0] out

);

always @* begin
	//It basically picks the important information and sign extends
	//using the MSB

      if (in[31:26] == 6'b000101) begin // B
        out[25:0] <= in[25:0];
        out[63:26] <= {64{out[25]}};

      end else if (in[31:24] == 8'b10110100) begin // CBZ
        out[19:0] <= in[23:5];
        out[63:20] <= {64{out[19]}};

      end else begin // D Type
        out[9:0] <= in[20:12];
        out[63:10] <= {64{out[9]}};
      end
	
end

endmodule