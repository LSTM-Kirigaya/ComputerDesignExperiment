module alu_ctrl(funct, ALUOp, alu_ctrl_out);
    input       [5:0] funct;
    input       [1:0] ALUOp;
    output reg  [3:0] alu_ctrl_out;

    // ALUOp to discriminate
    parameter LOAD   = 2'b00;
    parameter SAVE   = 2'b00;
    parameter BEQ    = 2'b01;
    parameter R_TYPE = 2'b10;

    // funct to discriminate
    parameter ADD  = 6'b100000;
    parameter SUB  = 6'b100010;
    parameter AND  = 6'b100100;
    parameter OR   = 6'b100101;
    parameter SLT  = 6'b101010;

    always @(*) 
    begin
        case(ALUOp)
            LOAD   : alu_ctrl_out = 4'b0010;
            SAVE   : alu_ctrl_out = 4'b0010;
            BEQ    : alu_ctrl_out = 4'b0110;
            R_TYPE:
            begin
                case(funct)
                    ADD  : alu_ctrl_out = 4'b0010;
                    SUB  : alu_ctrl_out = 4'b0110;
                    AND  : alu_ctrl_out = 4'b0000;
                    OR   : alu_ctrl_out = 4'b0001;
                    SLT  : alu_ctrl_out = 4'b0111;
                endcase
            end
        endcase    
    end
endmodule