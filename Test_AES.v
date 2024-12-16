`timescale 1ns / 1ps

module Test_AES;

    // 原始128位密钥
    reg [127:0] key;
    // 轮密钥
    wire [127:0] round_key0, round_key1, round_key2, round_key3, round_key4, 
                 round_key5, round_key6, round_key7, round_key8, round_key9, 
                 round_key10;
    // 128位输入状态
    reg [127:0] state;
    // 128位输出状态
    wire [127:0] state_out;

    // 实例化Key_Expansion模块
    Key_Expansion UUT_Key_Expansion (
        .key(key),
        .round_key0(round_key0),
        .round_key1(round_key1),
        .round_key2(round_key2),
        .round_key3(round_key3),
        .round_key4(round_key4),
        .round_key5(round_key5),
        .round_key6(round_key6),
        .round_key7(round_key7),
        .round_key8(round_key8),
        .round_key9(round_key9),
        .round_key10(round_key10)
    );

    // 实例化Add_RoundKey模块
    Add_RoundKey UUT_Add_RoundKey (
        .state(state),
        .round_key(round_key0), // 假设我们使用第一个轮密钥进行测试
        .state_out(state_out)
    );

    // 初始化过程
    initial begin
        // 生成随机的原始128位密钥
        key = $random;
   

        // 生成随机的128位状态
        state = $random;
  
        #10;
        

    end

endmodule