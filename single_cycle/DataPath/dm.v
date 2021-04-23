module dm_4k(alu_out, out2, MemWrite, clock, dm_out);
    input       [31:0] alu_out;     // result of alu
    input       [31:0] out2;        // result of im
    input              MemWrite;    // signal
    input              clock;       // signal

    output      [31:0] dm_out;      // result

    reg         [31:0] dm [1023:0];

    initial 
        $readmemh("./data/.data", dm, 0, 1023);  

    always @(posedge clock) 
        if (MemWrite)
        begin
            dm[alu_out[11:2]] = out2;
            // $display("%d", out2);
        end

    always @(dm[0] or dm[1] or dm[2] or dm[3] or dm[4] or dm[5]) 
    begin
        for (integer i = 0; i < 6; i = i + 1)
            $write("%d", dm[i]);
            $display(" ");
    end

    assign dm_out = dm[alu_out[11:2]];

endmodule
