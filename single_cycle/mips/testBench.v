`include "./mips.v"

module testbench();
    reg     clock;
    reg     reset;

    mips MIPS(
        .clock(clock),
        .reset(reset)
    );

    initial 
    begin
        clock <= 1;
        reset <= 1;
        #20 reset <= 0;

        #60000 $stop;
    end

    // generate clock pluses
    always  
    begin
        #40 clock = ~clock; 
    end

    initial 
    begin
        $dumpfile("wave.vcd");
        $dumpvars;    
    end

endmodule