module OR1 (
    input  PcStall1,
    input  PcStall2,
    output OR1_out 
);
    assign OR1_out = PcStall1 | PcStall2;

endmodule //OR

module OR2 (
    input  IF_ID_Stall1,
    input  IF_ID_Stall2,
    output OR2_out  
);
    assign OR2_out = IF_ID_Stall1 | IF_ID_Stall2;

endmodule //OR

module OR3 (
    input  HDU1_block,
    input  HDU2_block,
    input  Cause_block,
    output OR3_out
);

    assign OR3_out = HDU1_block | HDU2_block | Cause_block;

endmodule //OR

module OR4 (
    input  Skip_IF_Flush,
    input  Cause_IF_Flush,
    output OR4_out
);

    assign OR4_out = Skip_IF_Flush | Cause_IF_Flush;

endmodule //OR