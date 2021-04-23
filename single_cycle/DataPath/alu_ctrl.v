module alu_ctrl(funct, ALUOp, alu_ctrl_out);
    input       [5:0] funct;
    input       [2:0] ALUOp;
    output reg  [3:0] alu_ctrl_out;

    // ALUOp to discriminate
    parameter LW     = 3'b000;       // LW, SW, ADDI and ADDIU share the same operation type in ALU(all 'ADD')
    parameter SW     = 3'b000;
    parameter ADDI   = 3'b000;
    parameter ADDIU  = 3'b000;
    parameter BEQ    = 3'b001;
    parameter LUI    = 3'b011;
    parameter ORI    = 3'b100;
    parameter R_TYPE = 3'b010;

    // funct to discriminate
    parameter ADD  = 6'b100000;
    parameter SUB  = 6'b100010;
    parameter AND  = 6'b100100;
    parameter OR   = 6'b100101;
    parameter SLT  = 6'b101010;
    parameter XOR  = 6'b100110;
    parameter SLL  = 6'b000000;

    always @(*) 
    begin
        case(ALUOp)
            LW     : alu_ctrl_out = 4'b0010;
            SW     : alu_ctrl_out = 4'b0010;
            BEQ    : alu_ctrl_out = 4'b0110;
            LUI    : alu_ctrl_out = 4'b0101;
            ORI    : alu_ctrl_out = 4'b0001;    // ORI and OR share the same operation in ALU
            R_TYPE:
            begin
                case(funct)
                    ADD  : alu_ctrl_out = 4'b0010;
                    SUB  : alu_ctrl_out = 4'b0110;
                    AND  : alu_ctrl_out = 4'b0000;
                    OR   : alu_ctrl_out = 4'b0001;
                    SLT  : alu_ctrl_out = 4'b0111;
                    XOR  : alu_ctrl_out = 4'b0011;
                    SLL  : alu_ctrl_out = 4'b1000;
                endcase
            end
        endcase    
    end
endmodule