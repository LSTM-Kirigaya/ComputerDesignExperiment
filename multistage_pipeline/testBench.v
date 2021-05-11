`include "mips.v"
`timescale 10ns/10ns

module test();
    reg     clock;
    reg     reset;

    initial 
    begin
        clock <= 1;
        reset <= 1;
        #10 reset <= 0;
        #6000 $finish;
    end

    mips MIPS(
        .clock(clock),
        .reset(reset)
    );

    // generate clock pluses
    always  
        #10 clock = !clock; 
    
    initial 
    begin
        // $monitor($time, "");
        $dumpfile("wave.vcd");
        $dumpvars;    
    end
endmodule