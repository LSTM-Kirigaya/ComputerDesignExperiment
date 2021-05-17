module BU #(
    parameter BEQ    = 3'b000,              // branch equal
    parameter BNE    = 3'b001,              // branch not equal 
    parameter BGEZ   = 3'b010,              // branch greater than or equal to zero
    parameter BGTZ   = 3'b011,              // branch greater than zero
    parameter BLEZ   = 3'b100,              // branch less than or equal to zero
    parameter BLTZ   = 3'b101,              // branch less than zero
    parameter BGEZAL = 3'b110,              // branch greater than or equal to zero and link
    parameter BLTZAL = 3'b111               // branch less than zero and link
)(
    input      [ 2: 0] Branch,
    input      [31: 0] mux8_out,
    input      [31: 0] mux9_out,
    output reg         BU_out
);
    always @(*) begin
        case(Branch)
            BEQ    : BU_out = (mux8_out == mux9_out) ? 1 : 0;
            BNE    : BU_out = (mux8_out == mux9_out) ? 0 : 1;
            BGEZ   : BU_out = (mux8_out > 0 || mux8_out == 0) ? 1 : 0;
            BGTZ   : BU_out = (mux8_out > 0) ? 1 : 0;
            BLEZ   : BU_out = (mux8_out < 0 || mux8_out == 0) ? 1 : 0;
            BLTZ   : BU_out = (mux8_out < 0) ? 1 : 0;
            // part of link will be thrown to cooperation of controller, pc_add_out and mux5
            BGEZAL : BU_out = (mux8_out > 0 || mux8_out == 0) ? 1 : 0;
            BLTZAL : BU_out = (mux8_out < 0) ? 1 : 0;
        endcase
    end

endmodule //BU