module MEM_WB (clock, RegWrite, MemtoReg, dm_out, EX_MEM_alu_out, EX_MEM_mux1_out, MEM_WB_out);
    
    input               clock;

    // Controller's signal
    input               RegWrite;
    input               MemtoReg;
    input      [31: 0]  dm_out;
    input      [31: 0]  EX_MEM_alu_out;
    input      [ 4: 0]  EX_MEM_mux1_out;

    output reg [70: 0]  MEM_WB_out;

    always @(posedge clock) begin
        MEM_WB_out = {RegWrite, MemtoReg, dm_out, EX_MEM_alu_out, EX_MEM_mux1_out};
    end

endmodule //MEM_WB

// starting index and end of each instruction
/*

    MEM_WB_out[0]     :    RegWrite
    MEM_WB_out[1]     :    MemtoReg
    MEM_WB_out[33:2]  :    dm_out
    MEM_WB_out[65:34] :    EX_MEM_alu_out
    MEM_WB_out[70:66] :    EX_MEM_mux1_out
*/