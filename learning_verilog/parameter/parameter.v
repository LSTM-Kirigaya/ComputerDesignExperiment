module test_parameter(
        clock,
        out
    );
    parameter cycle = 200;
    parameter signal = 2'b00;
    input      clock;
    output reg out;

    always @(posedge clock) begin
        out = ~out;
    end
        

endmodule