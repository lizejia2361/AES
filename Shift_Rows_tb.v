`timescale 1ns / 1ps

module Shift_Rows_tb;

    // 输入和输出信号的声明
    reg [127:0] state;
    wire [127:0] shifted_state;

    // 实例化待测试模块
    Shift_Rows shift_rows_inst (
        .state(state),
        .shifted_state(shifted_state)
    );

    // 初始化过程
    initial begin
        // 初始化输入信号
        state = $random; // 随机生成128位状态
        
        // 等待一段时间以观察初始状态
        #10;
        

    end
    
endmodule