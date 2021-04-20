`include "./DataPath/data_path.v"
`include "./Controller/ctrl.v"

module mips(clock, reset);
    input   clock;
    input   reset;

    wire  [31: 0] instruction;
    
    // signal
    wire           RegDst;
    wire           Branch;
    wire           MemtoReg;
    wire   [ 1: 0] ALUOp;
    wire           MemWrite;
    wire           ALUSrc;
    wire           RegWrite;
    wire           Jump;

    data_path DataPath(
        .RegDst(RegDst),
        .Branch(Branch),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .clock(clock),
        .reset(reset),
        .instruction(instruction)
    );

    controller Controller(
        .opcode(instruction[31:26]),
        .funct(instruction[5:0]),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump)
    );
    
endmodule