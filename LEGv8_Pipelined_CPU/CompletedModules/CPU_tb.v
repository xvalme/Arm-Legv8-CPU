`include "CPU.v"
module CPU_tb();

reg clock;
wire [63:0] counter;
wire [31:0] instruction;
wire [63:0] read1, read2, ALUout, memdata;

always begin
#1 clock=~clock;
end

cpu cpu (clock, counter, instruction,
read1, read2, ALUout, memdata);

integer i;

initial begin

 $dumpfile("test.vcd");
 $dumpvars(0,cpu);

clock = 0;
#50

$finish;

end

endmodule