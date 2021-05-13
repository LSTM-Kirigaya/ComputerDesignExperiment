`include "./DataPath/data_path.v"
`include "./Controller/controller.v"

module mips(clock, reset);
    input   clock;
    input   reset;

    
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
    wire           JR;

    wire   [31: 0] IF_ID_im_out;

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
        .JR(JR),

        .clock(clock),
        .reset(reset),
        
        .IF_ID_im_out(IF_ID_im_out)
    );

    controller Controller(
        .opcode(IF_ID_im_out[31:26]),
        .funct(IF_ID_im_out[ 5: 0]),
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
        .JR(JR)
    );
    
endmodule