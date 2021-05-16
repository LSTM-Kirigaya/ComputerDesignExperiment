`include "./parameter.v"

module test_use();

    parameter cycle = 100;
    reg     clock;
    wire   	out;

    test_parameter #(
        .cycle  		( cycle   		),
        .signal 		( 2'b00 		))
    u_test_parameter(
        //input
        .clock 		( clock 		),

        //output
        .out   		( out   		)

        //inout
    );

    initial begin
        u_test_parameter.out = 1;
        clock = 0;
        $monitor("cycle=%d, out=%d",u_test_parameter.cycle, u_test_parameter.out);
        #100 $finish;
    end

    always #20 clock = ~clock;



endmodule //use