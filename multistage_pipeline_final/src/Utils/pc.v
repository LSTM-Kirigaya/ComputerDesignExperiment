module pc #(
    parameter initial_addr = 32'h0000_3000
)(
    input              clock,
    input              reset,
    input      [31: 0] npc_out,
    input              OR1_out,
    output reg [31: 0] pc_out
);

    always @(posedge clock ,negedge reset) begin
        if (reset)
            pc_out <= initial_addr;
        else if (OR1_out)
            pc_out <= npc_out;
    end

endmodule //pc