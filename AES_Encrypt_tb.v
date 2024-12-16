`timescale 1ns / 1ps

module AES_Encrypt_tb;

    // 输入和输出信号的声明
    reg [127:0] plaintext;
    reg [127:0] key;
    wire [127:0] ciphertext;

    // 实例化待测试模块
    AES_Encrypt AES_Encrypt_inst (
        .plaintext(plaintext),
        .key(key),
        .ciphertext(ciphertext)
    );

    // 初始化过程
    initial begin
        // 初始化输入信号
        plaintext = 128'h0123456789abcdeffedcba9876543210;
        key = 128'h000102030405060708090a0b0c0d0e0f;
        
        // 等待一段时间以观察初始状态
        #100;

    end
    
endmodule