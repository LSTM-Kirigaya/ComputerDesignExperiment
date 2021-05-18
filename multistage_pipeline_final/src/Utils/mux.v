module mux8 (
    input      [ 1: 0] Forward1A,
    input      [31: 0] regfile_out1,
    input      [31: 0] EX_MEM_mux5_out,
    input      [31: 0] mux6_out,
    output reg [31: 0] mux8_out
);
    always @(*) begin
        case(Forward1A)
            2'b10 : mux8_out = EX_MEM_mux5_out;
            2'b01 : mux8_out = mux6_out;
            3'b00 : mux8_out = regfile_out1;
        endcase
    end
endmodule // mux8


module mux9 (
    input      [ 1: 0] Forward1B,
    input      [31: 0] regfile_out2,
    input      [31: 0] EX_MEM_mux5_out,
    input      [31: 0] mux6_out,
    output reg [31: 0] mux9_out
);
    always @(*) begin
        case(Forward1B)
            2'b10 : mux9_out = EX_MEM_mux5_out;
            2'b01 : mux9_out = mux6_out;
            2'b00 : mux9_out = regfile_out2;
        endcase
    end
endmodule // mux9