`timescale 10ns/10ns
module clock_pulse;
    reg     clock;
    initial begin
        $display("start a clock pulse");    // 打印开始标记
        $dumpfile("wave.vcd");              // 指定记录模拟波形的文件
        $dumpvars(0, clock_pulse);          // 指定记录的模块层级
        clock <= 1;                         // 初始clock信号为1
        #6000 $finish;                      // 60000个单位时间后结束模拟
    end

    always begin
        #20 clock = !clock;                 // 每20个单位clock取反
    end

endmodule //clock_pulse