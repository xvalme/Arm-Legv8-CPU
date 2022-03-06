module reg2loc_mux (input [4:0] a, input [4:0] b, input in_cable, output reg [4:0] out);

always @* begin 

if (in_cable == 0) out <= a;
else out <= b;

end

endmodule