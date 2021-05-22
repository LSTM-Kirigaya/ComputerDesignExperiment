module hello ();
    reg [2:0] temp;
    initial begin
        temp = 3'b001;
        #10
        if (temp[1:0] == temp[2:0])
            $display("enter");
        $dumpfile("wave.vcd");
        $dumpvars;
        #6000 $finish;
    end

endmodule //hello