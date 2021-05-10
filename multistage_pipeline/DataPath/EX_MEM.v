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

    EX_MEM_out
    );

    input          clock;
    input          reset;

    // Controller signal
    input  [ 1: 0] LS_bit;
    input  [ 1: 0] Branch;
    input          MemtoReg;
    input          MemWrite;
    input          RegWrite;
    input          Jump;
    input          Ext_op;
    input          PctoReg;

    // Others
    input  [31: 0] branch_add_out;
    input          zero;
    input  [31: 0] ID_EX_pc_add_out;
    input  [25: 0] ID_EX_instr26;
    input  [31: 0] alu_out;
    input  [31: 0] ID_EX_regfile_out2;
    input  [ 4: 0] mux1_out;

    output reg [169:0] EX_MEM_out;



    always @(posedge clock) 
        EX_MEM_out = {
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
            mux1_out
        };


    // reset signal to control pc before pipeline full
    // ensure Branch and jump is 0
    always @(negedge reset) 
        EX_MEM_out = {
            2'b00,          
            MemtoReg,
            MemWrite,
            RegWrite,
            1'b0,
            PctoReg,

            branch_add_out,
            zero,
            ID_EX_pc_add_out,
            ID_EX_instr26,
            alu_out,
            ID_EX_regfile_out2,
            mux1_out
        };

    

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