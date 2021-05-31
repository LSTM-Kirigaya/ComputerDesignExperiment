module ID_EX (
    input               clock,
    input               reset,
    input       [ 1: 0] mux7_LS_bit,
    input       [ 2: 0] mux7_RegDst,
    input       [ 2: 0] mux7_DataDst,
    input               mux7_MemtoReg,
    input       [ 3: 0] mux7_ALUOp,
    input               mux7_MemWrite,
    input               mux7_ALUSrc,
    input               mux7_ShamtSrc,
    input               mux7_RegWrite,
    input               mux7_Ext_op,
    input       [ 3: 0] mux7_ExcCode,
    input       [31: 0] low_out,
    input       [31: 0] high_out,
    input       [31: 0] IF_ID_pc_add_out,
    input       [31: 0] mux8_out,
    input       [31: 0] mux9_out,
    input       [31: 0] Ext_out,
    input       [25: 0] instr26,

    output reg  [ 1: 0] ID_EX_LS_bit,
    output reg  [ 2: 0] ID_EX_RegDst,
    output reg  [ 2: 0] ID_EX_DataDst,
    output reg          ID_EX_MemtoReg,
    output reg  [ 3: 0] ID_EX_ALUOp,
    output reg          ID_EX_MemWrite,
    output reg          ID_EX_ALUSrc,
    output reg          ID_EX_ShamtSrc,
    output reg          ID_EX_RegWrite,
    output reg          ID_EX_Ext_op,
    output reg  [ 3: 0] ID_EX_ExcCode,
    output reg  [31: 0] ID_EX_low_out,
    output reg  [31: 0] ID_EX_high_out,
    output reg  [31: 0] ID_EX_pc_add_out,
    output reg  [31: 0] ID_EX_mux8_out,
    output reg  [31: 0] ID_EX_mux9_out,
    output reg  [31: 0] ID_EX_Ext_out,
    output reg  [25: 0] ID_EX_instr26
    
);

    always @(posedge clock) begin
        ID_EX_LS_bit      <=   mux7_LS_bit;
        ID_EX_RegDst      <=   mux7_RegDst;
        ID_EX_DataDst     <=   mux7_DataDst;
        ID_EX_MemtoReg    <=   mux7_MemtoReg;
        ID_EX_ALUOp       <=   mux7_ALUOp;
        ID_EX_MemWrite    <=   mux7_MemWrite;
        ID_EX_ALUSrc      <=   mux7_ALUSrc;
        ID_EX_ShamtSrc    <=   mux7_ShamtSrc;
        ID_EX_RegWrite    <=   mux7_RegWrite;
        ID_EX_Ext_op      <=   mux7_Ext_op;
        ID_EX_ExcCode     <=   mux7_ExcCode;
        ID_EX_low_out     <=   low_out;
        ID_EX_high_out    <=   high_out;
        ID_EX_pc_add_out  <=   IF_ID_pc_add_out;
        ID_EX_mux8_out    <=   mux8_out;
        ID_EX_mux9_out    <=   mux9_out;
        ID_EX_Ext_out     <=   Ext_out;
        ID_EX_instr26     <=   instr26;
    end

endmodule //ID_EX