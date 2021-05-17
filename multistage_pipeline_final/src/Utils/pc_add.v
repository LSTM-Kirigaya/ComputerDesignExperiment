module pc_add (
    input  [31: 0] pc_out,
    output [31: 0] pc_add_out
);
    assign pc_add_out = pc_out + 4;

endmodule //pc_add