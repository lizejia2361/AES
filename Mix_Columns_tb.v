`timescale 1ns / 1ps

module Mix_Columns_tb;

    // 输入和输出信号
    reg [127:0] state;
    wire [127:0] mixed_state;

    // 实例化MixColumns模块
    Mix_Columns UUT (
        .state(state),
        .mixed_state(mixed_state)
    );

    // 初始化输入数据
    initial begin
        // 初始化输入数据为随机值
        state = $random;

        

        // 等待一小段时间以观察输出
        #10;
        
       
    end

    

endmodule