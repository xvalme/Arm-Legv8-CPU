//Basic 4 bit up c counter with reset and enable 
module 4bit_upcounter (
    input clock,
    input reset,
    input enable,
    output out
);

//All imports should be wires
wire clock;
wire reset;
wire enable;

//Output data type:
reg [3:0] out;

//Everytime the clock goes up:
always @ (posedge clock)

begin:

    if (reset == 1'b1) begin:

        out <= #1 4'b0000;

    end 

    if (enable = 1'b1) begin:

        out <= #1 out + 1;

    end 

end

endmodule

