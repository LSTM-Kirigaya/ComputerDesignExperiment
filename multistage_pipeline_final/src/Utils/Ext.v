module Ext (
    input              Ext_op,
    input      [31: 0] IF_ID_im_out,
    output reg [31: 0] Ext_out
);
    always @(*) begin
        if (Ext_op)
            Ext_out = {{16{IF_ID_im_out[15]}}, IF_ID_im_out[15: 0]};
        else 
            Ext_out = {{16{1'b0}}, IF_ID_im_out[15: 0]};
    end

endmodule //Ext