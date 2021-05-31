module pc #(
    parameter initial_addr = 32'h0000_3000
)(
    input              clock,
    input              reset,
    input      [31: 0] npc_out,
    input              OR1_out,
    output reg [31: 0] pc_out
);
    // initial 
    always @(posedge reset) begin
        pc_out <= initial_addr;
    end

    always @(posedge clock && reset == 1) begin
        if (!OR1_out)              // OR1_out represents stall or not
            pc_out <= npc_out;
    end

endmodule //pc