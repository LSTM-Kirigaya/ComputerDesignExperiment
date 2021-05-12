module alu_ctrl(funct, ALUOp, alu_ctrl_out);
    input       [5:0] funct;
    input       [3:0] ALUOp;
    output reg  [3:0] alu_ctrl_out;

    /*

        About ALUOp of I type and J type:
        0010: R type
        0000: use add
        0001: use minus
        0011: load to upper 16-bit
        0101: use and
        0100: use or
        0110: use xor
        1010: use nor
        1000: use slt
    
    -> sample : LW, SW, ADDI and ADDIU share the same operation type in ALU(all 'ADD')
    */

    // ALUOp to discriminate
    parameter USE_R_TYPE  = 4'b0010;
    parameter USE_ADD     = 4'b0000;
    parameter USE_MINUS   = 4'b0001;
    parameter USE_UP16    = 4'b0011;
    parameter USE_AND     = 4'b0101;
    parameter USE_OR      = 4'b0100;
    parameter USE_XOR     = 4'b0110;
    parameter USE_NOR     = 4'b1010;
    parameter USE_SLT     = 4'b1000;


    // funct to discriminate
    parameter ADD  = 6'b100000;
    parameter ADDU = 6'b100001;
    parameter SUB  = 6'b100010;
    parameter SUBU = 6'b100011;
    parameter AND  = 6'b100100;
    parameter OR   = 6'b100101;
    parameter NOR  = 6'b100111;
    parameter XOR  = 6'b100110;

    parameter SLT  = 6'b101010;
    parameter SLTU = 6'b101011;
    parameter SLL  = 6'b000000;
    parameter SRL  = 6'b000010;
    parameter SRA  = 6'b000011;

    always @(*) 
    begin
        case(ALUOp) 
            USE_ADD    : alu_ctrl_out = 4'b0010;
            USE_MINUS  : alu_ctrl_out = 4'b0110;
            USE_UP16   : alu_ctrl_out = 4'b0101;
            USE_AND    : alu_ctrl_out = 4'b0000;
            USE_OR     : alu_ctrl_out = 4'b0001;
            USE_XOR    : alu_ctrl_out = 4'b0011;
            USE_NOR    : alu_ctrl_out = 4'b1010;
            USE_SLT    : alu_ctrl_out = 4'b0111;
            USE_R_TYPE:    
            begin
                case(funct)
                    ADD  : alu_ctrl_out = 4'b0010;
                    ADDU : alu_ctrl_out = 4'b0010;
                    SUB  : alu_ctrl_out = 4'b0110;
                    SUBU : alu_ctrl_out = 4'b0110;
                    AND  : alu_ctrl_out = 4'b0000;
                    OR   : alu_ctrl_out = 4'b0001;
                    NOR  : alu_ctrl_out = 4'b1010;
                    XOR  : alu_ctrl_out = 4'b0011;
                    SLT  : alu_ctrl_out = 4'b0111;
                    SLTU : alu_ctrl_out = 4'b0111;
                    SLL  : alu_ctrl_out = 4'b1000;
                    SRL  : alu_ctrl_out = 4'b0100;
                    SRA  : alu_ctrl_out = 4'b1100;
                endcase
            end
        endcase    
    end
endmodule