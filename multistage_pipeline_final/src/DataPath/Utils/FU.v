module FU (
    input   BU_out,
    input   Jump,
    input   Jr,
    output  Skip_IF_Flush
);

    assign Skip_IF_Flush = BU_out | Jump | Jr;

endmodule //FU