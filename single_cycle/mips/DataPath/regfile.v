module regfile(rs, rt, rd, data, RegWrite, clock, reset, out1, out2);
    input   [ 4:0]    rs, rt, rd;       // three registers
    input   [31:0]    data;             // data to write to the register
    input             clock, reset; 
    input             RegWrite;         // signal to control whether write change to register or 

    output  [31:0]    out1, out2;       // out of two registers, which are rs and rd

    reg     [31:0]    registers[31:0];  // heap of 32 registers
    integer           i;

    // assign value to out
    assign out1 <= (rs == 0) ? 0 : registers[rs];
    assign out2 <= (rd == 0) ? 0 : registers[rd];

    // whether write change to register
    always @(posedge clock or negedge reset) 
    begin
        if (RegWrite)
            registers[rd] <= data;
        else if (reset)                 // reset all the register to zero
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'h0000_0000;
    end
endmodule