//module Mix_Columns(
//    input wire [127:0] state, // 128位输入状态
//    output wire [127:0] mixed_state // 128位输出状态，经过列混合后的结果
//);
//
//// 定义有限域乘法函数
//function [7:0] GF_mul;
//    input [7:0] a;
//    begin
//        // 计算乘以2的结果，即左移一位，如果最高位为1，则加上0x1B (x^8 + x^4 + x^3 + x + 1)
//        GF_mul = a << 1;
//        if (a[7]) GF_mul = GF_mul ^ 8'h1B;
//    end
//endfunction
//
//// 定义有限域加法函数（异或）
//function [7:0] GF_add;
//    input [7:0] a, b;
//    begin
//        GF_add = a ^ b;
//    end
//endfunction
//
//// 将128位输入状态分解为4x4的状态矩阵
//reg [7:0] state_matrix[3:0][3:0];
//integer i, j;
//always @(*) begin
//    for (i = 0; i < 4; i = i + 1) begin
//        for (j = 0; j < 4; j = j + 1) begin
//            state_matrix[i][j] = state[(8*j + 8*i) -: 8];
//        end
//    end
//end
//
//// 列混合操作
//reg [7:0] mixed_matrix[3:0][3:0];
//always @(*) begin
//    for (i = 0; i < 4; i = i + 1) begin
//        mixed_matrix[0][i] = GF_add(GF_mul(state_matrix[0][i]), GF_mul(state_matrix[1][i]));
//        mixed_matrix[1][i] = GF_add(GF_mul(state_matrix[1][i]), GF_mul(state_matrix[2][i]));
//        mixed_matrix[2][i] = GF_add(GF_mul(state_matrix[2][i]), GF_mul(state_matrix[3][i]));
//        mixed_matrix[3][i] = GF_add(GF_mul(state_matrix[3][i]), GF_add(state_matrix[0][i], state_matrix[1][i]));
//    end
//end
//
//// 将混合后的矩阵重新组合成128位输出状态
//assign mixed_state = {
//    mixed_matrix[0][0], mixed_matrix[1][0], mixed_matrix[2][0], mixed_matrix[3][0],
//    mixed_matrix[0][1], mixed_matrix[1][1], mixed_matrix[2][1], mixed_matrix[3][1],
//    mixed_matrix[0][2], mixed_matrix[1][2], mixed_matrix[2][2], mixed_matrix[3][2],
//    mixed_matrix[0][3], mixed_matrix[1][3], mixed_matrix[2][3], mixed_matrix[3][3]
//};
//
//endmodule
module Mix_Columns(
    input wire [127:0] state, // 128位输入数据
    output reg [127:0] mixed_state // 128位输出数据
);

    // 状态矩阵，4x4，每个元素8位
    reg [7:0] state_r[3:0][3:0];
    reg [7:0] result[3:0][3:0];

    // 将输入数据拆分成4x4状态矩阵
    integer i, j;
    always @(*) begin
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                state_r[i][j] = state[(j * 4 + i) * 8 +: 8];
            end
        end
    end

    // 列混合操作
    always @(*) begin
        for (i = 0; i < 4; i = i + 1) begin
            result[0][i] = (state_r[0][i] << 1) ^ (state_r[1][i] << 1) ^ state_r[2][i] ^ state_r[3][i] ^
                          ((state_r[0][i] ^ state_r[1][i]) & 8'h80) ? 8'h1B : 8'd0; // 0x1B是AES中的固定多项式
            result[1][i] = state_r[0][i] ^ (state_r[1][i] << 1) ^ (state_r[2][i] << 1) ^ state_r[3][i] ^
                          ((state_r[1][i] ^ state_r[2][i]) & 8'h80) ? 8'h1B : 8'd0;
            result[2][i] = state_r[0][i] ^ state_r[1][i] ^ (state_r[2][i] << 1) ^ (state_r[3][i] << 1) ^
                          ((state_r[2][i] ^ state_r[3][i]) & 8'h80) ? 8'h1B : 8'd0;
            result[3][i] = (state_r[0][i] << 1) ^ state_r[1][i] ^ state_r[2][i] ^ (state_r[3][i] << 1) ^
                          ((state_r[3][i] ^ state_r[0][i]) & 8'h80) ? 8'h1B : 8'd0;
        end
    end

    // 将结果矩阵重新组合为128位输出数据
    always @(*) begin
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                mixed_state[(j * 4 + i) * 8 +: 8] = result[i][j];
            end
        end
    end

endmodule