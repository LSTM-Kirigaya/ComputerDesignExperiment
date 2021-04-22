`include "./DataPath/data_path.v"
`include "./Controller/controller.v"

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
    wire           Ext_op;

    data_path DataPath(
        .RegDst(RegDst),
        .Branch(Branch),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .Ext_op(Ext_op),
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
        .Jump(Jump),
        .Ext_op(Ext_op)
    );
    
endmodule