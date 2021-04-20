// reset or update pc
module pc (NPC, clock, reset, PC);

    input   [31:0] NPC;     // npc
    input          clock;     // clock signal
    input          reset;     // reset
    output  [31:0] PC;

    reg     [31:0] PC;      // assign as a register

    parameter initial_address = 32'h0000_3000;

    always @(posedge clock or posedge reset) 
    begin
        if (reset)
            PC <= initial_address;
        else
            PC <= NPC;
    end

endmodule //pc