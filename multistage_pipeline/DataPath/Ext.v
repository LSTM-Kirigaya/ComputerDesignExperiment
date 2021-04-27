module Ext(input_num, Ext_op, output_num);
    input  [15:0] input_num;
    input         Ext_op;
    output reg [31:0] output_num;

    always @(*) 
        if (Ext_op)
            output_num = {{16{input_num[15]}}, input_num[15:0]};
        else
            output_num = {{16{1'b0}}, input_num[15:0]};

endmodule