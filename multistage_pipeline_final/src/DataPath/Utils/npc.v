module npc (
    input              Jr,                  // use jr, jump register
    input              Jump,                // use jump, jump addr 
    input              BU_out,              // use branch, jump base + ext_out
    input      [31: 0] pc_add_out,
    input      [31: 0] IF_ID_im_out,        // im_out,  for jump
    input      [31: 0] Ext_out,             // Ext out, for branch
    input      [31: 0] mux8_out,            // GPR[rs], for jr
    output reg [31: 0] npc_out
);
    reg        [31: 0] PC;                  // resume the origin current pc value

    always @(*) begin
        if (Jr) begin
            npc_out = mux8_out;
        end
        else if (Jump) begin
            PC = pc_add_out - 4;
            npc_out = {PC[31:28], {IF_ID_im_out[25: 0] << 2}};
        end
        else if (BU_out) begin
            npc_out = (Ext_out << 2) + pc_add_out - 4;
        end
        else begin
            npc_out = pc_add_out;
        end
    end

endmodule // npc