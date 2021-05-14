typedef struct packed 
{
    reg [ 5: 0] opcode;
    reg [25: 0] addr;
}J_TYPE;

module test();
    J_TYPE i;

    initial begin
        $monitor("opcode=%h, addr=%h", i.opcode, i.addr);
        #200 $finish;
    end

    assign i.opcode = 6'b001000;
    assign i.addr   = 0;

endmodule