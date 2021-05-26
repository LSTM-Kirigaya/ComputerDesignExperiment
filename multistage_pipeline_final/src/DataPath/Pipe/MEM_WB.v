module MEM_WB (
    input               clock,
    input               reset,
    input               EX_MEM_MemtoReg,
    input               EX_MEM_RegWrite,
    input       [31: 0] dm_out,
    input       [31: 0] EX_MEM_mux5_out,
    input       [ 5: 0] EX_MEM_mux1_out,
    input       [63: 0] EX_MEM_prod,

    output reg          MEM_WB_MemtoReg,
    output reg          MEM_WB_RegWrite,
    output reg  [31: 0] MEM_WB_dm_out,
    output reg  [31: 0] MEM_WB_mux5_out,
    output reg  [ 5: 0] MEM_WB_mux1_out,
    output reg  [63: 0] MEM_WB_prod
);

    always @(posedge clock) begin
        MEM_WB_MemtoReg <=   EX_MEM_MemtoReg;
        MEM_WB_RegWrite <=   EX_MEM_RegWrite;
        MEM_WB_dm_out   <=   dm_out;
        MEM_WB_mux5_out <=   EX_MEM_mux5_out;
        MEM_WB_mux1_out <=   EX_MEM_mux1_out;
        MEM_WB_prod     <=   EX_MEM_prod;
    end

endmodule //MEM_WB