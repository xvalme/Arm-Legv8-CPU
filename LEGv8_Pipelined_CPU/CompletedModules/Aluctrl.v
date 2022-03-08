module aluctrl (
  input [1:0] ALU_Op,
  input [10:0] ALU_INSTRUCTION,
  output reg [3:0] ALU_Out);
  
 always @(ALU_INSTRUCTION or ALU_Op) begin

	case (ALU_Op)
      2'b00 : ALU_Out = 4'b0010;
      2'b01 : ALU_Out = 4'b0111;
      2'b10 : begin

        case (ALU_INSTRUCTION)
          11'b10001011000 : ALU_Out <= 4'b0010; // ADD
          11'b11001011000 : ALU_Out <= 4'b0110; // SUB
          11'b10001010000 : ALU_Out <= 4'b0000; // AND
          11'b10101010000 : ALU_Out <= 4'b0001; // ORR
          default: ALU_Out <= 4'b0000;
        endcase
      end
      default: ALU_Out = 4'b0000;
    endcase
 
 end

endmodule