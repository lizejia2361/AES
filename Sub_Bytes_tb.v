`timescale 1ns / 1ps

module Sub_Bytes_tb;

    // 输入和输出信号的声明
    reg [127:0] state;
    wire [127:0] subbed_state;

    // 实例化待测试模块
    Sub_Bytes sub_bytes_inst (
        .state(state),
        .subbed_state(subbed_state)
    );

    // 初始化过程
    initial begin
        // 初始化输入信号
        state = $random; // 随机生成128位状态
        
        // 等待一段时间以观察初始状态
        #10;
        
        
    end
    
endmodule