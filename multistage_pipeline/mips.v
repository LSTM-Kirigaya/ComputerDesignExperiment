`include "./DataPath/data_path.v"
`include "./Controller/controller.v"

module mips(clock, reset);
    input   clock;
    input   reset;

    wire   [31: 0] ID_EX_im_out;
    
    // signal
    wire   [ 1: 0] LS_bit;
    wire           RegDst;
    wire   [ 1: 0] Branch;
    wire           MemtoReg;
    wire   [ 3: 0] ALUOp;
    wire           MemWrite;
    wire           ALUSrc;
    wire           RegWrite;
    wire           Jump;
    wire           Ext_op;
    wire           PctoReg;

    data_path DataPath(
        .LS_bit(LS_bit),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .Ext_op(Ext_op),
        .PctoReg(PctoReg),

        .clock(clock),
        .reset(reset),
        
        .ID_EX_im_out(ID_EX_im_out)
    );

    controller Controller(
        .opcode(ID_EX_im_out[31:26]),
        .LS_bit(LS_bit),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Jump(Jump),
        .Ext_op(Ext_op),
        .PctoReg(PctoReg)
    );
    
endmodule