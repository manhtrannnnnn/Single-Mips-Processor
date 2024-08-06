module control(
    input [5:0] opcode,
    output wire branch,
    output wire regdst,
    output wire memtoreg,
    output wire alusrc,
    output wire regwrite,
    output wire jump,
    output wire memwrite,
    output wire [1:0] aluop
);
      
    reg [8:0] tmp;

    assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, aluop, jump} = tmp;

    always @(*) begin
        case(opcode)
            6'b000000: tmp = 9'b110000110; // R-type
            6'b100011: tmp = 9'b101001000; // lw
            6'b101011: tmp = 9'b001010000; // sw
            6'b000100: tmp = 9'b000100010; // beq
            6'b001000: tmp = 9'b101000100; // addi
            6'b001100: tmp = 9'b101000100; // andi
            6'b001101: tmp = 9'b101000100; // ori
            6'b001010: tmp = 9'b101000100; // slti
            6'b000010: tmp = 9'b000000001; // jump
            default:   tmp = 9'bxxxxxxxxx; // default case
        endcase
    end
endmodule

