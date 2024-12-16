module Shift_Rows(
    input wire [127:0] state, // 128位输入状态
    output wire [127:0] shifted_state // 128位输出状态，经过行移位后的结果
);

// 将128位输入状态分解为4x4的状态矩阵
reg [7:0] row0[3:0], row1[3:0], row2[3:0], row3[3:0];

// 提取每一行的字节
integer i;
always @(*) begin
    for (i = 0; i < 4; i = i + 1) begin
        row0[i] = state[(8*i + 7) -: 8]; // 使用-:操作符进行动态位宽选择
        row1[i] = state[(8*(i+1) + 3) -: 8]; // 第二行循环左移一位
        row2[i] = state[(8*(i+2) + 2) -: 8]; // 第三行循环左移两位
        row3[i] = state[(8*(i+3) + 1) -: 8]; // 第四行循环左移三位
    end
end

// 将移位后的行重新组合成128位输出状态
assign shifted_state = {
    {row0[3], row0[0], row0[1], row0[2]},
    {row1[3], row1[0], row1[1], row1[2]},
    {row2[3], row2[0], row2[1], row2[2]},
    {row3[3], row3[0], row3[1], row3[2]}
};

endmodule