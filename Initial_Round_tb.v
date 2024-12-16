`timescale 1ns / 1ps

module Initial_Round_tb;

    // 输入和输出信号的声明
    reg [127:0] plaintext;
    reg [127:0] key;
    wire [127:0] state;

    // 实例化待测试模块
    Initial_Round initial_round_inst (
        .plaintext(plaintext),
        .key(key),
        .state(state)
    );

    // 初始化过程
    initial begin
        // 初始化输入信号
        plaintext = $random; // 随机生成128位明文
        key = $random;     // 随机生成128位密钥
        
        // 等待一段时间以观察初始状态
        #10;
        

    end
    
endmodule