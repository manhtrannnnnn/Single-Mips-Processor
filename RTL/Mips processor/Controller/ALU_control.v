module ALU_control(
  input [5:0] funct,
  input [5:0] opcode,
  input [1:0] aluop,
  output reg [3:0] alucontrol
);

  always @(*) begin
      case (aluop)
        2'b00: alucontrol = 4'b0010; // lw, sw
        2'b01: alucontrol = 4'b0110; // beq
        2'b10: begin
          case (opcode)
            6'b001000: alucontrol = 4'b0010; // addi
            6'b001100: alucontrol = 4'b0000; // andi
            6'b001101: alucontrol = 4'b0001; // ori
            6'b001010: alucontrol = 4'b0111; // slti
            default:   alucontrol = 4'bxxxx; // undefined
          endcase
        end
        default: begin
          case (funct) // R-type instructions
            6'b100000: alucontrol = 4'b0010; // add
            6'b100010: alucontrol = 4'b0110; // subtract
            6'b100100: alucontrol = 4'b0000; // and
            6'b100101: alucontrol = 4'b0001; // or
            6'b101010: alucontrol = 4'b0111; // slt
            default:   alucontrol = 4'bxxxx; // undefined
          endcase
        end
      endcase
  end
endmodule

