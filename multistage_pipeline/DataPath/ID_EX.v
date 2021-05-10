module ID_EX (
    clock, 
    reset,

    LS_bit,
    RegDst, 
    Branch, 
    MemtoReg, 
    ALUOp, 
    MemWrite, 
    ALUSrc, 
    RegWrite, 
    Jump, 
    Ext_op,
    PctoReg,

    IF_ID_pc_add_out, 
    regfile_out1, 
    regfile_out2, 
    instr26,

    ID_EX_out
    );

    // system signal
    input          clock;
    input          reset;

    // input of controller
    input  [ 1: 0] LS_bit;
    input          RegDst;   
    input  [ 1: 0] Branch;
    input          MemtoReg;
    input  [ 3: 0] ALUOp;
    input          MemWrite;
    input          ALUSrc;
    input          RegWrite;
    input          Jump;
    input          Ext_op;
    input          PctoReg;

    // input of regfile
    input  [31: 0] regfile_out1;
    input  [31: 0] regfile_out2;

    // input of IF/ID
    input  [31: 0] IF_ID_pc_add_out;

    // input of instruction left
    input  [25: 0] instr26;

    output reg [137:0] ID_EX_out;

    always @(posedge clock) begin
        ID_EX_out = {
            LS_bit,
            RegDst, 
            Branch, 
            MemtoReg, 
            ALUOp, 
            MemWrite, 
            ALUSrc, 
            RegWrite, 
            Jump, 
            Ext_op,
            PctoReg,
            IF_ID_pc_add_out, 
            regfile_out1, 
            regfile_out2, 
            instr26
        };
    end

endmodule //ID_EX

// starting index and end of each instruction
/*

    ID_EX_out[1:0]     :  LS_bit
    ID_EX_out[2]       :  RegDst
    ID_EX_out[4:3]     :  Branch
    ID_EX_out[5]       :  MemtoReg
    ID_EX_out[9:6]     :  ALUOp
    ID_EX_out[10]      :  MemWrite
    ID_EX_out[11]      :  ALUSrc
    ID_EX_out[12]      :  RegWrite
    ID_EX_out[13]      :  Jump
    ID_EX_out[14]      :  Ext_op
    ID_EX_out[15]      :  PctoReg

    ID_EX_out[47:16]   :  IF_ID_pc_add_out
    ID_EX_out[79:48]   :  regfile_out1
    ID_EX_out[111:80]  :  regfile_out2
    ID_EX_out[137:112] :  instr26

*/