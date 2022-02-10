`include "4_bit_upcounter.v"

module tb();

//Input as registers and output as wires

reg clock, reset, enable;
wire[3:0] out;

initial begin

	$
	