module ForwardUnit1 (
    input      [ 4: 0] rs,
    input      [ 4: 0] rt,
    input              EX_MEM_RegWrite,
    input      [ 5: 0] EX_MEM_mux1_out,
    input              MEM_WB_RegWrite,
    input      [ 5: 0] MEM_WB_mux1_out,
    output reg [ 1: 0] Forward1A,                   // Forward signal to rs
    output reg [ 1: 0] Forward1B                    // Forward signal to rt
);
    // forward rs
    always @(*) begin
        if (EX_MEM_RegWrite && EX_MEM_mux1_out != 0 && rs == EX_MEM_mux1_out)
            Forward1A = 2'b10;
        else if (MEM_WB_RegWrite && MEM_WB_mux1_out != 0 && rs == MEM_WB_mux1_out)
            Forward1A = 2'b01;
        else 
            Forward1A = 2'b00;
    end

    // forward rt
    always @(*) begin
        if (EX_MEM_RegWrite && EX_MEM_mux1_out != 0 && rt == EX_MEM_mux1_out)
            Forward1B = 2'b10;
        else if (MEM_WB_RegWrite && MEM_WB_mux1_out != 0 && rt == MEM_WB_mux1_out)
            Forward1B = 2'b01;
        else
            Forward1B = 2'b00;
    end

endmodule // ForwardUnit1


module ForwardUnit2 (
    input      [ 4: 0] ID_EX_rs,
    input      [ 4: 0] ID_EX_rt,
    input              EX_MEM_RegWrite,
    input      [ 5: 0] EX_MEM_mux1_out,
    input              MEM_WB_RegWrite,
    input      [ 5: 0] MEM_WB_mux1_out,
    output reg [ 1: 0] Forward2A,                   // Forward signal to ID_EX_rs(op1)
    output reg [ 1: 0] Forward2B                    // Forward signal to ID_EX_rt(op2)
);

    // forward ID_EX_rs
    always @(*) begin
        if (EX_MEM_RegWrite && EX_MEM_mux1_out != 0 && ID_EX_rs == EX_MEM_mux1_out)
            Forward2A = 2'b10;
        else if (MEM_WB_RegWrite && MEM_WB_mux1_out != 0 && ID_EX_rs == MEM_WB_mux1_out)
            Forward2A = 2'b01;
        else 
            Forward2A = 2'b00;
    end

    always @(*) begin
        if (EX_MEM_RegWrite && EX_MEM_mux1_out != 0 && ID_EX_rt == EX_MEM_mux1_out)
            Forward2B = 2'b10;
        else if (MEM_WB_RegWrite && MEM_WB_mux1_out != 0 && ID_EX_rt == MEM_WB_mux1_out)
            Forward2B = 2'b01;
        else 
            Forward2B = 2'b00;
    end

endmodule // ForwardUnit2

module ForwardUnit3 (
    input              EX_MEM_RegWrite,
    input      [ 5: 0] EX_MEM_mux1_out,
    input              MEM_WB_RegWrite,
    input      [ 5: 0] MEM_WB_mux1_out,
    input      [63: 0] EX_MEM_prod,
    input      [63: 0] MEM_WB_prod,

    output reg [ 2: 0] Forward3A,
    output reg [ 2: 0] Forward3B
);  
    // low
    always @(*) begin
        if      (EX_MEM_RegWrite && EX_MEM_mux1_out == 33)  // lo <- alu_out
            Forward3A = 3'b010;
        else if (EX_MEM_RegWrite && EX_MEM_mux1_out == 34)  // lo <- prod[31: 0]
            Forward3A = 3'b100;
        else if (MEM_WB_RegWrite && MEM_WB_mux1_out == 33)  // lo <- alu_out
            Forward3A = 3'b001;
        else if (MEM_WB_RegWrite && MEM_WB_mux1_out == 34)  // lo <- prod[31: 0]
            Forward3A = 3'b011;
        else 
            Forward3A = 3'b000;
    end

    // high
    always @(*) begin
        if      (EX_MEM_RegWrite && EX_MEM_mux1_out == 32)  // hi <- alu_out
            Forward3B = 3'b010;
        else if (EX_MEM_RegWrite && EX_MEM_mux1_out == 34)  // hi <- prod[63:32]
            Forward3B = 3'b100;
        else if (MEM_WB_RegWrite && MEM_WB_mux1_out == 32)  // hi <- alu_out
            Forward3B = 3'b001;
        else if (MEM_WB_RegWrite && MEM_WB_mux1_out == 34)  // hi <- prod[63:32]
            Forward3B = 3'b011;
        else                                                // origin
            Forward3B = 3'b000;
    end 

endmodule // ForwardUnit3