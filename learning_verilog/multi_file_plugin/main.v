module main ();
    reg clock;

    initial begin
        clock = 0;
        #60 $finish;
    end

    always #10 clock = ~clock;


    v1 u_v1(
        //input
        .clock 		( clock 		)

        //output

        //inout
    );

    v2 u_v2(
        //input
        .clock 		( clock 		)

        //output

        //inout
    );

   

endmodule //main