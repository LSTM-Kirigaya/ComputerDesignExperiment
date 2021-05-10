module MEM_WB (
    clock, 
    reset,

    RegWrite, 
    MemtoReg,
    PctoReg,

    EX_MEM_pc_add_out,
    dm_out, 
    EX_MEM_alu_out, 
    EX_MEM_mux1_out, 
    MEM_WB_out
    );
    
    input               clock;
    input               reset;

    // Controller's signal
    input               RegWrite;
    input               MemtoReg;
    input               PctoReg;

    input      [31: 0]  EX_MEM_pc_add_out;
    input      [31: 0]  dm_out;
    input      [31: 0]  EX_MEM_alu_out;
    input      [ 4: 0]  EX_MEM_mux1_out;

    output reg [103: 0]  MEM_WB_out;

    always @(posedge clock) 
        MEM_WB_out = {
            RegWrite,
            MemtoReg,
            PctoReg,

            EX_MEM_pc_add_out,
            dm_out,
            EX_MEM_alu_out,
            EX_MEM_mux1_out
        };
    

endmodule //MEM_WB

// starting index and end of each instruction
/*

    MEM_WB_out[0]     :    RegWrite
    MEM_WB_out[1]     :    MemtoReg
    MEM_WB_out[2]     :    PctoReg

    MEM_WB_out[34:3]    :    EX_MEM_pc_add_out
    MEM_WB_out[66:35]   :    dm_out
    MEM_WB_out[98:67]   :    EX_MEM_alu_out
    MEM_WB_out[103:99]  :    EX_MEM_mux1_out
*/