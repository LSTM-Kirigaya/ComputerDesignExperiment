`include "counter.v"        // same as C's include, you can include a file or its path
module test;
    // Make a reset that pulses once
    reg reset;
    initial 
    begin
        # 17 reset = 1;
        # 11 reset = 0;
        # 29 reset = 1;
        # 11 reset = 0;
        # 100 $stop;
    end

    reg clock = 0;
    always #5 clock = !clock;

    wire [ 7: 0] value;
    counter c1(value, clock, reset);

    initial 
        $monitor("At time %t, value = %h (%0d)",
                $time, value, value);
    // Make

endmodule //counter_tb