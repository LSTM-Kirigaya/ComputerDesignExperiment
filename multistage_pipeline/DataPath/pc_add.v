module pc_add (PC, pc_add_out);
    input    [31: 0] PC;
    output   [31: 0] pc_add_out;

    assign pc_add_out = PC + 4;

endmodule //pc_adder