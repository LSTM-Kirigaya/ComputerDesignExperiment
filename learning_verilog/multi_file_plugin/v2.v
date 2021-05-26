module v2 (
    input clock
);
    always @(clock) begin
        $display("v2 clock value: %d", clock);
    end

endmodule // v2