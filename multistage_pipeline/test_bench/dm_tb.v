`include "./DataPath/dm.v"

`timescale 10ns/10ns

module test;
    reg     clock;

    initial begin
        clock <= 1;
        #6000 $finish;
    end
	
    wire  [31: 0] alu_out = 32'h1001_0000;
    wire  [31: 0] out2 = 32'h0000_0003;
    reg           MemWrite = 1'b1;
    wire  [31: 0] dm_out;

    dm_4k u_dm_4k(
        .alu_out(alu_out),
        .out2(out2),
        .MemWrite(MemWrite),
        .clock(clock),
        .dm_out(dm_out)
    );

    always 
        #40 clock = !clock; 

endmodule //test
