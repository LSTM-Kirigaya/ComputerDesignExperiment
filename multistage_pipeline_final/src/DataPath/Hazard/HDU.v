/*
    case (LS_bit)
    00 : no load/save
    01 : load/save word
    10 : load/save half word
    11 : load/save byte

    case (MemWrite)
    0 : no save
    1 : save

    case (use_stage)
    0 : ID
    1 : EX
*/

module HDU1 (
    input               clock,
    input               reset,
    input               use_stage,
    input               ID_EX_RegWrite,
    input       [ 1: 0] EX_MEM_LS_bit,
    input               EX_MEM_MemWrite,
    input       [ 4: 0] rs,
    input       [ 4: 0] rt,
    input       [ 5: 0] mux1_out,
    input       [ 5: 0] EX_MEM_mux1_out,
    output reg          PcStall1,
    output reg          IF_ID_Stall1,
    output reg          HDU1_block
);
    `define TARGET {PcStall1, IF_ID_Stall1, HDU1_block}
    // initial
    always @(posedge reset) begin
        `TARGET = {1'b0, 1'b0, 1'b0};
    end

    // judge next level's alu or load
    always @(*) begin
        if (use_stage == 0 && ID_EX_RegWrite &&         // next level to the branch and jump
        (rs == mux1_out || rt == mux1_out))
            `TARGET = {1'b1, 1'b1, 1'b1};
        else if (use_stage == 0 && 
            EX_MEM_MemWrite != 1 && EX_MEM_LS_bit != 2'b00 &&
            (rs == EX_MEM_mux1_out || rt == EX_MEM_mux1_out))
            `TARGET = {1'b1, 1'b1, 1'b1};
        else 
            `TARGET = {1'b0, 1'b0, 1'b0};
    end
    // judge the next of next level's load

endmodule // HDU1

module HDU2 (
    input               clock,
    input               reset,
    input               use_stage,
    input       [ 1: 0] ID_EX_LS_bit,
    input               ID_EX_MemWrite,
    input       [ 4: 0] rs,
    input       [ 4: 0] rt,
    input       [ 5: 0] mux1_out,
    output reg          PcStall2,
    output reg          IF_ID_Stall2,
    output reg          HDU2_block
);
    `define TARGET  {PcStall2, IF_ID_Stall2, HDU2_block}

    // initial 
    always @(posedge reset) begin
        `TARGET = {1'b0, 1'b0, 1'b0};
    end

    // solve load-use conflict
    always @(*) begin
        // stall the pipeline when load-use
        // "ID_EX_MemWrite != 1 && ID_EX_LS_bit != 2'b00" make sure the instruction is a load
        if (use_stage == 1 && 
            ID_EX_MemWrite != 1 && ID_EX_LS_bit != 2'b00 && 
            (rs == mux1_out || rt == mux1_out))
            `TARGET = {1'b1, 1'b1, 1'b1};
        else
            `TARGET = {1'b0, 1'b0, 1'b0};
    end

endmodule //HDU2