`include "Sign_extender.v"

module tb();

reg [31:0] in = 0;
wire [63:0] out;

sign_extender test (.in(in), .out(out));

initial begin

in = 'd15;
#1 $display ("INITIAL: %b", in);
$display ("FINAL: %b", out);
in = -'d15;
#5 $display ("INITIAL: %b", in);
$display ("FINAL: %b", out);

#5 $finish;

end

endmodule