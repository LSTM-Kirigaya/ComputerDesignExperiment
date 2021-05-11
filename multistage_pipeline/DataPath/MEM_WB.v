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

    MEM_WB_RegWrite,
    MEM_WB_MemtoReg,
    MEM_WB_PctoReg,
    MEM_WB_pc_add_out,
    MEM_WB_dm_out,
    MEM_WB_alu_out,
    MEM_WB_mux1_out

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

    output reg          MEM_WB_RegWrite;
    output reg          MEM_WB_MemtoReg;
    output reg          MEM_WB_PctoReg;
    output reg [31: 0]  MEM_WB_pc_add_out;
    output reg [31: 0]  MEM_WB_dm_out;
    output reg [31: 0]  MEM_WB_alu_out;
    output reg [ 4: 0]  MEM_WB_mux1_out;


    always @(posedge clock) 
    begin
        MEM_WB_RegWrite      <=  RegWrite;
        MEM_WB_MemtoReg      <=  MemtoReg;
        MEM_WB_PctoReg       <=  PctoReg;
        MEM_WB_pc_add_out    <=  EX_MEM_pc_add_out;
        MEM_WB_dm_out        <=  dm_out;
        MEM_WB_alu_out       <=  EX_MEM_alu_out;
        MEM_WB_mux1_out      <=  EX_MEM_mux1_out;
    end
    

endmodule //MEM_WB
