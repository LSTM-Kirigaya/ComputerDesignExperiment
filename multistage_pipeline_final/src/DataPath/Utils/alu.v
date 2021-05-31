module alu #(
    /*
        alu_ctrl_out field
    */
    parameter ADD_OP     = 5'b00000,
    parameter ADDU_OP    = 5'b00001,
    parameter SUB_OP     = 5'b00010,
    parameter SUBU_OP    = 5'b00011,
    parameter SLT_OP     = 5'b00100,
    parameter SLTU_OP    = 5'b00101,
    parameter MULT_OP    = 5'b00110,
    parameter MULTU_OP   = 5'b00111,
    parameter DIV_OP     = 5'b01000,
    parameter DIVU_OP    = 5'b01001,
    parameter AND_OP     = 5'b01010,
    parameter OR_OP      = 5'b01011,
    parameter NOR_OP     = 5'b01100,
    parameter XOR_OP     = 5'b01101,
    parameter LUI_OP     = 5'b01110,
    parameter SLL_OP     = 5'b01111,
    parameter SRL_OP     = 5'b10000,
    parameter SRA_OP     = 5'b10001,
    parameter MTHI_OP    = 5'b10010,
    parameter MTLO_OP    = 5'b10011    
)(
    input              clock,
    input              reset,
    input      [ 4: 0] alu_ctrl_out,
    input      [31: 0] op1,
    input      [31: 0] op2,
    input      [ 4: 0] shamt,
    output reg [31: 0] alu_out,
    output reg [63: 0] prod,
    output reg         overflow,
    output reg         divideZero
);
    reg [32: 0] temp; 
    always @(posedge clock or posedge reset) begin
        overflow <= 0;
        divideZero <= 0;
    end

    always @(*) begin
        case (alu_ctrl_out)
            // 1. add with overflow detection
            ADD_OP  : begin
                temp = {op1[31], op1} + {op2[31], op2};
                if (temp[32:0] == {temp[31], temp[31:0]})
                begin
                    alu_out = temp;
                    overflow = 1'b0;
                end
                else 
                    overflow = 1'b1;
                divideZero = 0;
            end
            // 2. add without overflow detectiom
            ADDU_OP : begin
                temp = op1 + op2;
                alu_out = temp;
                divideZero = 0;
            end
            // 3. sub with overflow detection
            SUB_OP : begin
                temp = {op1[31], op1} - {op2[31], op2};
                if (temp[32:0] == {temp[31],temp[31:0]})
                begin
                    alu_out = temp;
                    overflow = 1'b0;
                end
                else 
                    overflow = 1'b1;
                divideZero = 0;
            end
            // 4. sub without overflow detection
            SUBU_OP : begin
                temp = op1 - op2;
                alu_out = temp;
                overflow = 0;
                divideZero = 0;
            end
            SLT_OP : begin
                if ($signed(op1) < $signed(op2))
                    alu_out = 1;
                else 
                    alu_out = 0;
                overflow = 0;
                divideZero = 0;
            end
            SLTU_OP : begin
                if ({1'b0, op1} < {1'b0, op2})
                    alu_out = 1;
                else 
                    alu_out = 0;
                overflow = 0;
                divideZero = 0;
            end
            MULT_OP : begin
                prod = op1 * op2;
                overflow = 0;
                divideZero = 0;
            end
            MULTU_OP : begin
                prod = {1'b0, op1} * {1'b0, op2};
                overflow = 0;
                divideZero = 0;
            end
            DIV_OP : begin
                if (op2 == 0)
                begin
                    divideZero = 1;
                end
                else begin
                    prod[63:32] = op1 % op2;
                    prod[31: 0] = op1 / op2;
                    divideZero = 0;
                end
                overflow = 0;
            end
            DIVU_OP : begin
                if (op2 == 0)
                begin
                    divideZero = 1;
                end
                else begin
                    prod[63:32] = $signed({1'b0, op1} % {1'b0, op2});
                    prod[31: 0] = $signed({1'b0, op1} / {1'b0, op2});
                    divideZero = 0;
                end
                overflow = 0;
            end
            AND_OP : begin
                alu_out = op1 & op2;
                overflow = 0;
                divideZero = 0;
            end
            OR_OP : begin
                alu_out = op1 | op2;
                overflow = 0;
                divideZero = 0;
            end
            NOR_OP : begin
                alu_out = ~(op1 | op2);
                overflow = 0;
                divideZero = 0;
            end
            XOR_OP : begin
                alu_out = op1 ^ op2;
                overflow = 0;
                divideZero = 0;
            end
            LUI_OP : begin
                alu_out = {op2, {16{1'b0}}};
                overflow = 0;
                divideZero = 0;
            end
            SLL_OP : begin
                temp = op2 << shamt;
                alu_out = temp;
                overflow = 0;
                divideZero = 0;
            end
            SRL_OP : begin
                temp = op2 >> shamt;
                alu_out = temp;
                overflow = 0;
                divideZero = 0;
            end
            SRA_OP : begin
                temp = $signed(op2) >>> shamt;
                alu_out = temp;
                overflow = 0;
                divideZero = 0;
            end
            // HI ← GPR[rs]
            MTHI_OP : begin
                alu_out = op1;
                overflow = 0;
                divideZero = 0;
            end
            // LO ← GPR[rs]
            MTLO_OP : begin
                alu_out = op1;
                overflow = 0;
                divideZero = 0;
            end
        endcase
    end

endmodule // alu