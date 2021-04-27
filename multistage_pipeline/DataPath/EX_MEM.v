module EX_MEM (clock, Branch, MemtoReg, MemWrite, RegWrite, Jump,
        branch_add_out, zero, alu_out, ID_EX_regfile_out2, mux1_out, EX_MEM_out);

    input          clock;

    // Controller signal
    input          Branch;
    input          MemtoReg;
    input          MemWrite;
    input          RegWrite;
    input          Jump;

    // Others
    input  [31: 0] branch_add_out;
    input          zero;
    input  [31: 0] alu_out;
    input  [31: 0] ID_EX_regfile_out2;
    input  [ 4: 0] mux1_out;

    output reg [106:0] EX_MEM_out;

    always @(posedge clock) begin
        EX_MEM_out = {Branch, MemtoReg, MemWrite, RegWrite, Jump,
            branch_add_out, zero, alu_out, ID_EX_regfile_out2, mux1_out};
    end

endmodule //EX_MEM

// starting index and end of each instruction
/*
    EX_MEM_out[0]  :    Branch
    EX_MEM_out[1]  :    MemtoReg
    EX_MEM_out[2]  :    MemWrite
    EX_MEM_out[3]  :    RegWrite
    EX_MEM_out[4]  :    Jump
    EX_MEM_out[36:5] :  branch_add_out
    EX_MEM_out[37]   :  zero
    EX_MEM_out[69:38]:  alu_out
    EX_MEM_out[101:70]: ID_EX_regfile_out2
    EX_MEM_out[106:102]:mux1_out
 

*/