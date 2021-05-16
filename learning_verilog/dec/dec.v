module dec(
    input_num, 
    out0,
    out1,
    out2,
    out3,
    out4,
    out5,
    out6,
    out7
    );

    input [2:0] input_num;
    output reg  out0;
    output reg  out1;
    output reg  out2;
    output reg  out3;
    output reg  out4;
    output reg  out5;
    output reg  out6;
    output reg  out7;

    `define out = {out0, out1, out2, out3, out4, out5, out6, out7}

    always @(*) begin
        if (input_num == 3'b000)
            `out = {1, 0, 0, 0};
    end

endmodule //dec