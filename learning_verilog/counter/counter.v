module counter (out, clock, reset);
    parameter WIDTH = 8;
    input                       clock, reset;
    output reg [WIDTH - 1 : 0]  out;

    always @(posedge clock or posedge reset) 
        if (reset)
            out <= 0;
        else  
            out <= out + 1;    

endmodule //counter