`include "./DataPath/dm.v"

`timescale 10ns/10ns

module test();
    reg     clock;

    initial begin
        clock <= 1;
        #6000 $finish;
    end
	
    wire [31:0] 	dm_out;

    // dm_4k u_dm_4k(
    //     //input
    //     .EX_MEM_alu_out      		( EX_MEM_alu_out      		),
    //     .EX_MEM_regfile_out2 		( EX_MEM_regfile_out2 		),
    //     .LS_bit              		( LS_bit              		),
    //     .MemWrite            		( MemWrite            		),
    //     .clock               		( clock               		),
    //     .Ext_op              		( Ext_op              		),

    //     //output
    //     .dm_out              		( dm_out              		)

    //     //inout
    // );

    

    always 
        #40 clock = !clock; 

endmodule //test
