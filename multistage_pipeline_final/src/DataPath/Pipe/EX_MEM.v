module EX_MEM (
    input              clock,
    input              reset,
    input      [ 1: 0] ID_EX_LS_bit,
    input              ID_EX_MemtoReg,
    input              ID_EX_MemWrite,
    input              ID_EX_RegWrite,
    input              ID_EX_Ext_op,
    input      [63: 0] prod,
    input      [31: 0] mux5_out,
    input      [31: 0] mux3_out,
    input      [ 5: 0] mux1_out,

    output reg [ 1: 0] EX_MEM_LS_bit,
    output reg         EX_MEM_MemtoReg,
    output reg         EX_MEM_MemWrite,
    output reg         EX_MEM_RegWrite,
    output reg         EX_MEM_Ext_op,
    output reg [63: 0] EX_MEM_prod,
    output reg [31: 0] EX_MEM_mux5_out,
    output reg [31: 0] EX_MEM_mux3_out,
    output reg [ 5: 0] EX_MEM_mux1_out
);

    always @(posedge clock) begin
        EX_MEM_LS_bit   <=   ID_EX_LS_bit;
        EX_MEM_MemtoReg <=   ID_EX_MemtoReg;
        EX_MEM_MemWrite <=   ID_EX_MemWrite;
        EX_MEM_RegWrite <=   ID_EX_RegWrite;
        EX_MEM_Ext_op   <=   ID_EX_Ext_op;
        EX_MEM_prod     <=   prod;
        EX_MEM_mux5_out <=   mux5_out;
        EX_MEM_mux3_out <=   mux3_out;
        EX_MEM_mux1_out <=   mux1_out;
    end

endmodule // EX_MEM