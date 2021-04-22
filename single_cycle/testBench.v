`include "mips.v"
`timescale 10ns/10ns

module test();
    reg     clock;
    reg     reset;

    initial 
    begin
        clock <= 1;
        reset <= 1;
        #20 reset <= 0;
        #60000 $stop;
    end

    mips MIPS(
        .clock(clock),
        .reset(reset)
    );

    // generate clock pluses
    always  
        #40 clock = !clock; 

    initial 
    begin
        $dumpfile("wave.vcd");
        $dumpvars;    
    end
endmodule