module regfile(
    rs, 
    rt, 
    rd, 
    data, 
    RegWrite, 
    clock, 
    reset, 
    regfile_out1, 
    regfile_out2
    );
    
    input   [ 4:0]    rs, rt, rd;       // three registers
    input   [31:0]    data;             // data to write to the register
    input             clock, reset; 
    input             RegWrite;         // signal to control whether write change to register or 
    

    output  [31:0]    regfile_out1, regfile_out2;       // out of two registers, which are rs and rd

    reg     [31:0]    registers[31:0];  // heap of 32 registers
    integer           i;

    // assign value to out
    assign regfile_out1 = (rs == 0) ? 0 : registers[rs];
    assign regfile_out2 = (rt == 0) ? 0 : registers[rt];

    // always @(rs or rt) begin
    //     $display("\033[35mrs = %h, rt = %h\033[0m", rs, rt);
    // end

    // always @(regfile_out1 or regfile_out2) begin        // for debug
    //     $display("\033[35mregfile_regfile_out1 = %h, regfile_regfile_out2 = %h\033[0m", regfile_out1, regfile_out2);
    // end

    // whether write change to register
    always @(posedge clock or posedge reset) 
    begin
        if (RegWrite && rd != 5'b00000)
            registers[rd] <= data;
        else if (reset)                 // reset all the register to zero
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'h0000_0000;
    end
endmodule