module EX_MEM (
    clock, 
    reset,

    LS_bit,
    Branch, 
    MemtoReg, 
    MemWrite, 
    RegWrite, 
    Jump,
    Ext_op,
    PctoReg,

    branch_add_out, 
    zero, 
    ID_EX_pc_add_out,
    ID_EX_instr26,
    alu_out, 
    ID_EX_regfile_out2, 
    mux1_out,

    EX_MEM_LS_bit,
    EX_MEM_Branch,
    EX_MEM_MemtoReg,
    EX_MEM_MemWrite,
    EX_MEM_RegWrite,
    EX_MEM_Jump,
    EX_MEM_Ext_op,
    EX_MEM_PctoReg,
    EX_MEM_branch_add_out,
    EX_MEM_zero,
    EX_MEM_pc_add_out,
    EX_MEM_instr26,
    EX_MEM_alu_out,
    EX_MEM_regfile_out2,
    EX_MEM_mux1_out

    );

    input          clock;
    input          reset;

    // Controller signal
    input       [ 1: 0] LS_bit;
    input       [ 1: 0] Branch;
    input               MemtoReg;
    input               MemWrite;
    input               RegWrite;
    input               Jump;
    input               Ext_op;
    input               PctoReg;

    // Others
    input       [31: 0] branch_add_out;
    input               zero;
    input       [31: 0] ID_EX_pc_add_out;
    input       [25: 0] ID_EX_instr26;
    input       [31: 0] alu_out;
    input       [31: 0] ID_EX_regfile_out2;
    input       [ 4: 0] mux1_out;

    output reg  [ 1: 0] EX_MEM_LS_bit;        
    output reg  [ 1: 0] EX_MEM_Branch;        
    output reg          EX_MEM_MemtoReg;      
    output reg          EX_MEM_MemWrite;      
    output reg          EX_MEM_RegWrite;      
    output reg          EX_MEM_Jump;
    output reg          EX_MEM_Ext_op;        
    output reg          EX_MEM_PctoReg;       
    output reg  [31: 0] EX_MEM_branch_add_out;
    output reg          EX_MEM_zero;
    output reg  [31: 0] EX_MEM_pc_add_out;
    output reg  [25: 0] EX_MEM_instr26;
    output reg  [31: 0] EX_MEM_alu_out;
    output reg  [31: 0] EX_MEM_regfile_out2;
    output reg  [ 4: 0] EX_MEM_mux1_out;


    always @(posedge clock) 
    begin
        EX_MEM_LS_bit           <=  LS_bit;
        EX_MEM_Branch           <=  Branch;
        EX_MEM_MemtoReg         <=  MemtoReg;
        EX_MEM_MemWrite         <=  MemWrite;
        EX_MEM_RegWrite         <=  RegWrite;
        EX_MEM_Jump             <=  Jump;
        EX_MEM_Ext_op           <=  Ext_op;
        EX_MEM_PctoReg          <=  PctoReg;
        EX_MEM_branch_add_out   <=  branch_add_out;
        EX_MEM_zero             <=  zero;
        EX_MEM_pc_add_out       <=  ID_EX_pc_add_out;
        EX_MEM_instr26          <=  ID_EX_instr26;
        EX_MEM_alu_out          <=  alu_out;
        EX_MEM_regfile_out2     <=  ID_EX_regfile_out2;
        EX_MEM_mux1_out         <=  mux1_out;
    // $display("%h", EX_MEM_out[74:43]);
    end

    // reset signal to control pc before pipeline full
    // ensure Branch and jump is 0
    // always @(negedge reset) 
    // begin
    //     EX_MEM_out = {
    //         mux1_out,
    //         ID_EX_regfile_out2,
    //         alu_out,
    //         ID_EX_instr26,
    //         32'h0000_3000,
    //         zero,
    //         branch_add_out,

    //         PctoReg,
    //         Ext_op,
    //         1'b0,
    //         RegWrite,
    //         MemWrite,
    //         MemtoReg,
    //         2'b00,
    //         LS_bit
    //     };
    // end
    

endmodule //EX_MEM

// starting index and end of each instruction
/*

    EX_MEM_out[1:0]  :    LS_bit
    EX_MEM_out[3:2]  :    Branch
    EX_MEM_out[4]    :    MemtoReg
    EX_MEM_out[5]    :    MemWrite
    EX_MEM_out[6]    :    RegWrite
    EX_MEM_out[7]    :    Jump
    EX_MEM_out[8]    :    Ext_op
    EX_MEM_out[9]    :    PctoReg

    EX_MEM_out[41:10]    :  branch_add_out
    EX_MEM_out[42]       :  zero
    EX_MEM_out[74:43]    :  ID_EX_pc_add_out,
    EX_MEM_out[100:75]   :  ID_EX_instr26,
    EX_MEM_out[132:101]  :  alu_out
    EX_MEM_out[164:133]  :  ID_EX_regfile_out2
    EX_MEM_out[169:165]  :  mux1_out

*/