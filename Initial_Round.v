module Initial_Round(
    input wire [127:0] plaintext,  // 128位明文输入
    input wire [127:0] key,       // 128位密钥输入
    output wire [127:0] state     // 128位输出，明文与密钥异或后的结果
);

// 异或操作
assign state = plaintext ^ key;

endmodule