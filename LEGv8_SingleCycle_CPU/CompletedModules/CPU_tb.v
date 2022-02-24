`include "CPU.v"

module CPU_tb();

reg clock;
wire [63:0] counter;
wire [31:0] instruction;
wire [63:0] read1, read2, ALUout, memdata;

always #1 clock=~clock;

cpu cpu (clock, counter, instruction,
read1, read2, ALUout, memdata);

integer i;

initial begin
clock = 0;
#1 $display("Count: %d Inst: %b R1:%d R2:%d ALUout:%d memdata:%d", 
counter, instruction, read1, read2, ALUout, memdata);
for (i = 0; i<5;i = i+1) begin 
#2 $display("Count: %d Inst: %b R1:%d R2:%d ALUout:%d memdata:%d", 
counter, instruction, read1, read2, ALUout, memdata);
end


$finish;

end

endmodule