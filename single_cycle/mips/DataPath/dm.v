module dm_4k(alu_out, out2, MemWrite, clock, dm_out);
    input       [31:0] alu_out;     // result of alu
    input       [31:0] out2;        // result of im
    input              MemWrite;    // signal
    input              clock;       // signal

    output reg  [31:0] dm_out;      // result

    reg [31:0] dm [1023:0];

    always @(posedge clock) 
    begin
        if (MemWrite)
            dm[alu_out[11:2]] <= out2;  
    end

    assign dm_out = dm[alu_out[11:2]];

endmodule