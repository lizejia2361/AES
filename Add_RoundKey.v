module Add_RoundKey(
    input wire [127:0] state,    // 128位输入状态
    input wire [127:0] round_key, // 128位轮密钥
    output wire [127:0] state_out // 128位输出状态，轮密钥加后的结果
);

// 将128位状态和128位轮密钥进行异或操作
assign state_out = state ^ round_key;

endmodule