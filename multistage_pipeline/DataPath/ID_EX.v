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

    ID_EX_LS_bit,
    ID_EX_RegDst,   
    ID_EX_Branch,
    ID_EX_MemtoReg,
    ID_EX_ALUOp,
    ID_EX_MemWrite,
    ID_EX_ALUSrc,
    ID_EX_RegWrite,
    ID_EX_Jump,
    ID_EX_Ext_op,
    ID_EX_PctoReg,
    ID_EX_regfile_out1,    
    ID_EX_regfile_out2,
    ID_EX_pc_add_out,
    ID_EX_instr26
    );

    // system signal
    input          clock;
    input          reset;

    // input of controller
    input       [ 1: 0] LS_bit;
    input               RegDst;   
    input       [ 1: 0] Branch;
    input               MemtoReg;
    input       [ 3: 0] ALUOp;
    input               MemWrite;
    input               ALUSrc;
    input               RegWrite;
    input               Jump;
    input               Ext_op;
    input               PctoReg;
    input       [31: 0] regfile_out1;        // input of regfile
    input       [31: 0] regfile_out2;
    input       [31: 0] IF_ID_pc_add_out;    // input of IF/ID
    input       [25: 0] instr26;             // input of instruction left

    output reg  [ 1: 0] ID_EX_LS_bit;  
    output reg          ID_EX_RegDst;  
    output reg  [ 1: 0] ID_EX_Branch;  
    output reg          ID_EX_MemtoReg;
    output reg  [ 3: 0] ID_EX_ALUOp;
    output reg          ID_EX_MemWrite;
    output reg          ID_EX_ALUSrc;
    output reg          ID_EX_RegWrite;
    output reg          ID_EX_Jump;
    output reg          ID_EX_Ext_op;
    output reg          ID_EX_PctoReg;
    output reg  [31: 0] ID_EX_regfile_out1;
    output reg  [31: 0] ID_EX_regfile_out2;
    output reg  [31: 0] ID_EX_pc_add_out;
    output reg  [25: 0] ID_EX_instr26;       

    always @(posedge clock) begin
        // $display($time, "%h", IF_ID_pc_add_out);
        ID_EX_LS_bit            <=  LS_bit;
        ID_EX_RegDst            <=  RegDst;
        ID_EX_Branch            <=  Branch;
        ID_EX_MemtoReg          <=  MemtoReg;
        ID_EX_ALUOp             <=  ALUOp;
        ID_EX_MemWrite          <=  MemWrite;
        ID_EX_ALUSrc            <=  ALUSrc;
        ID_EX_RegWrite          <=  RegWrite;
        ID_EX_Jump              <=  Jump;
        ID_EX_Ext_op            <=  Ext_op;
        ID_EX_PctoReg           <=  PctoReg;
        ID_EX_regfile_out1      <=  regfile_out1;
        ID_EX_regfile_out2      <=  regfile_out2;
        ID_EX_pc_add_out  <=  IF_ID_pc_add_out;
        ID_EX_instr26           <=  instr26;
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