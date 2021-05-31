module regfile (
    input              clock,
    input              reset,
    input              MEM_WB_RegWrite,
    input      [ 4: 0] rs,
    input      [ 4: 0] rt,                    
    input      [ 5: 0] MEM_WB_mux1_out, // rd      
    input      [31: 0] mux6_out,        // data
    input      [63: 0] MEM_WB_prod,     // prod               
    output reg [31: 0] low_out,
    output reg [31: 0] high_out,
    output reg [31: 0] regfile_out1,
    output reg [31: 0] regfile_out2
);
    /*
        0~31 : general registers
        32   : $hi
        33   : $lo
    */

    reg    [31: 0] registers[34: 0];
    integer        i;
    
    // load data from regfile
    always @(negedge clock) begin           // we should load data in the latter half of the cycle in order to let update appear first
        // half of the cycle
        high_out     = registers[32];
        low_out      = registers[33];
        regfile_out1 = (rs == 0) ? 0 : registers[rs];
        regfile_out2 = (rt == 0) ? 0 : registers[rt];
    end
    
    always @(posedge reset) begin
        for (i = 0; i < 34; i = i + 1)
            registers[i] = 0;
    end

    // Write mux6_out to regfile
    always @(posedge clock) begin
        if (MEM_WB_RegWrite && MEM_WB_mux1_out != 0)
        begin
            if (MEM_WB_mux1_out == 34)           // result of mult of div
            begin
                registers[32] = MEM_WB_prod[63:32];     // high
                registers[33] = MEM_WB_prod[31: 0];     // low
            end
            else  
                registers[MEM_WB_mux1_out] = mux6_out;
        end            
    end
    
endmodule //regfile