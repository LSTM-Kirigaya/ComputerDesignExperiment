module v1 (
    input clock
);
    always @(clock) begin
        $display("v1 clock value: %d", clock);
    end

endmodule // v1