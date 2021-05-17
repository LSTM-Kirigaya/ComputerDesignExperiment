module regfile (
    input              clock,
    input              reset,
    input              MEM_WB_RegWrite,
    input      [ 4: 0] rs,
    input      [ 4: 0] rt,                    
    input      [ 4: 0] rd,                          
    input      [31: 0] data,                        
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

    reg    [31: 0] registers[33: 0];
    integer        i;
    
    // load data from regfile
    always @(*) begin
        #5              // half of the cycle
        assign high_out     = registers[32];
        assign low_out      = registers[33];
        assign regfile_out1 = (rs == 0) ? 0 : registers[rs];
        assign regfile_out2 = (rt == 0) ? 0 : registers[rt];
    end
    

    // Write data to regfile
    always @(posedge clock or negedge reset) begin
        if (MEM_WB_RegWrite && rd != 0)
            registers[rd] = data;
        else if (reset)
            for (i = 0; i < 34; i = i + 1)
                registers[i] = 0;
    end
    
endmodule //regfile