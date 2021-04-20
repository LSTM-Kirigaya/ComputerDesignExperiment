module Ext(input_num, output_num);
    input  [15:0] input_num;
    output [15:0] output_num;

    assign output_num <= {{16{input_num[15]}}, input_num[15:0]};

endmodule