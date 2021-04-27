module branch_add (ID_EX_pc_add_out, Ext_out, branch_add_out);
    input  [31: 0] ID_EX_pc_add_out;
    input  [31: 0] Ext_out;
    output [31: 0] branch_add_out;
    
    assign branch_add_out = (Ext_out << 2) + ID_EX_pc_add_out;

endmodule //branch_add