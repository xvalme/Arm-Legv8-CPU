`include "Shift_extender.v"

module tb();

reg [63:0] in;
wire [63:0] out;

shift_extender test (.in(in), .out(out));

initial begin

in = 'd4563456;
$display ("INITIAL: %b", in);
#5 $display ("FINAL:   %b", out);
in = -'d15;
$display ("INITIAL: %b", in);
#5 $display ("FINAL:   %b", out);

#5 $finish;

end

endmodule