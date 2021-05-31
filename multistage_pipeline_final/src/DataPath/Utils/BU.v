module BU #(
    parameter BEQ       = 4'b0000,              // branch equal
    parameter BNE       = 4'b0001,              // branch not equal 
    parameter BGEZ      = 4'b0010,              // branch greater than or equal to zero
    parameter BGTZ      = 4'b0011,              // branch greater than zero
    parameter BLEZ      = 4'b0100,              // branch less than or equal to zero
    parameter BLTZ      = 4'b0101,              // branch less than zero
    parameter BGEZAL    = 4'b0110,              // branch greater than or equal to zero and link
    parameter BLTZAL    = 4'b0111,              // branch less than zero and link
    parameter NO_BRANCH = 4'b1000               // no branch
)(
    input      [ 3: 0] Branch,
    input      [31: 0] mux8_out,
    input      [31: 0] mux9_out,
    output reg         BU_out
);


    always @(*) begin
        case(Branch)
            BEQ       : BU_out = (mux8_out == mux9_out) ? 1 : 0;
            BNE       : BU_out = (mux8_out == mux9_out) ? 0 : 1;
            BGEZ      : BU_out = ($signed(mux8_out) > 0 || mux8_out == 0) ? 1 : 0;
            BGTZ      : BU_out = ($signed(mux8_out) > 0) ? 1 : 0;
            BLEZ      : BU_out = ($signed(mux8_out) < 0 || mux8_out == 0) ? 1 : 0;
            BLTZ      : BU_out = ($signed(mux8_out) < 0) ? 1 : 0;
            // part of link will be thrown to cooperation of controller, pc_add_out and mux5
            BGEZAL    : BU_out = ($signed(mux8_out) > 0 || mux8_out == 0) ? 1 : 0;
            BLTZAL    : BU_out = ($signed(mux8_out) < 0) ? 1 : 0;
            NO_BRANCH : BU_out = 0;
        endcase
    end

endmodule //BU