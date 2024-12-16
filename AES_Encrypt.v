module AES_Encrypt(
    input wire [127:0] plaintext,      // 128位明文输入
    input wire [127:0] key,           // 128位密钥输入
    output wire [127:0] ciphertext    // 128位密文输出
);

    // 内部信号声明
    wire [127:0] state0,state0_Sub_Bytes,state0_Shift_Rows,state0_Mix_Columns;
    wire [127:0] state1,state1_Sub_Bytes,state1_Shift_Rows,state1_Mix_Columns;
    wire [127:0] state2,state2_Sub_Bytes,state2_Shift_Rows,state2_Mix_Columns;
    wire [127:0] state3,state3_Sub_Bytes,state3_Shift_Rows,state3_Mix_Columns;
    wire [127:0] state4,state4_Sub_Bytes,state4_Shift_Rows,state4_Mix_Columns;
    wire [127:0] state5,state5_Sub_Bytes,state5_Shift_Rows,state5_Mix_Columns;
    wire [127:0] state6,state6_Sub_Bytes,state6_Shift_Rows,state6_Mix_Columns;
    wire [127:0] state7,state7_Sub_Bytes,state7_Shift_Rows,state7_Mix_Columns;
    wire [127:0] state8,state8_Sub_Bytes,state8_Shift_Rows,state8_Mix_Columns;
    wire [127:0] state9,state9_Sub_Bytes,state9_Shift_Rows;

    wire [127:0] round_key0, round_key1, round_key2, round_key3, round_key4, 
                round_key5, round_key6, round_key7, round_key8, round_key9, 
                round_key10;
    reg [127:0] round_key; // 用于存储当前轮的密钥

    // 实例化密钥扩展模块
    Key_Expansion key_expansion (
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

    // 实例化初始变换模块
    Initial_Round initial_round (
        .plaintext(plaintext),
        .key(key),
        .state(state0)
    );

    // 9轮循环
//0
            Sub_Bytes sub_bytes0 (
                .state(state0),
                .subbed_state(state0_Sub_Bytes)
            );
            Shift_Rows shift_rows0 (
                .state(state0_Sub_Bytes),
                .shifted_state(state0_Shift_Rows)
            );
            Mix_Columns mix_columns0 (
                .state(state0_Shift_Rows),
                .mixed_state(state0_Mix_Columns)
            );

            Add_RoundKey add_round_key0 (
                .state(state0_Mix_Columns),
                .round_key(round_key0),
                .state_out(state1)
            );

//1
            Sub_Bytes sub_bytes1 (
                .state(state1),
                .subbed_state(state1_Sub_Bytes)
            );
            Shift_Rows shift_rows1 (
                .state(state1_Sub_Bytes),
                .shifted_state(state1_Shift_Rows)
            );
            Mix_Columns mix_columns1 (
                .state(state1_Shift_Rows),
                .mixed_state(state1_Mix_Columns)
            );

            Add_RoundKey add_round_key1 (
                .state(state1_Mix_Columns),
                .round_key(round_key1),
                .state_out(state2)
            );
//2
            Sub_Bytes sub_bytes2 (
                .state(state2),
                .subbed_state(state2_Sub_Bytes)
            );
            Shift_Rows shift_rows2 (
                .state(state2_Sub_Bytes),
                .shifted_state(state2_Shift_Rows)
            );
            Mix_Columns mix_columns2 (
                .state(state2_Shift_Rows),
                .mixed_state(state2_Mix_Columns)
            );

            Add_RoundKey add_round_key2 (
                .state(state2_Mix_Columns),
                .round_key(round_key2),
                .state_out(state3)
            );
//3
            Sub_Bytes sub_bytes3 (
                .state(state3),
                .subbed_state(state3_Sub_Bytes)
            );
            Shift_Rows shift_rows3 (
                .state(state3_Sub_Bytes),
                .shifted_state(state3_Shift_Rows)
            );
            Mix_Columns mix_columns3 (
                .state(state3_Shift_Rows),
                .mixed_state(state3_Mix_Columns)
            );

            Add_RoundKey add_round_key3 (
                .state(state3_Mix_Columns),
                .round_key(round_key3),
                .state_out(state4)
            );
//4
            Sub_Bytes sub_bytes4 (
                .state(state4),
                .subbed_state(state4_Sub_Bytes)
            );
            Shift_Rows shift_rows4 (
                .state(state4_Sub_Bytes),
                .shifted_state(state4_Shift_Rows)
            );
            Mix_Columns mix_columns4 (
                .state(state4_Shift_Rows),
                .mixed_state(state4_Mix_Columns)
            );

            Add_RoundKey add_round_key4 (
                .state(state4_Mix_Columns),
                .round_key(round_key4),
                .state_out(state5)
            );
//5
            Sub_Bytes sub_bytes5 (
                .state(state5),
                .subbed_state(state5_Sub_Bytes)
            );
            Shift_Rows shift_rows5 (
                .state(state5_Sub_Bytes),
                .shifted_state(state5_Shift_Rows)
            );
            Mix_Columns mix_columns5 (
                .state(state5_Shift_Rows),
                .mixed_state(state5_Mix_Columns)
            );

            Add_RoundKey add_round_key5 (
                .state(state5_Mix_Columns),
                .round_key(round_key5),
                .state_out(state6)
            );
//6
            Sub_Bytes sub_bytes6 (
                .state(state6),
                .subbed_state(state6_Sub_Bytes)
            );
            Shift_Rows shift_rows6 (
                .state(state6_Sub_Bytes),
                .shifted_state(state6_Shift_Rows)
            );
            Mix_Columns mix_columns6 (
                .state(state6_Shift_Rows),
                .mixed_state(state6_Mix_Columns)
            );

            Add_RoundKey add_round_key6 (
                .state(state6_Mix_Columns),
                .round_key(round_key6),
                .state_out(state7)
            );
//7
            Sub_Bytes sub_bytes7 (
                .state(state7),
                .subbed_state(state7_Sub_Bytes)
            );
            Shift_Rows shift_rows7 (
                .state(state7_Sub_Bytes),
                .shifted_state(state7_Shift_Rows)
            );
            Mix_Columns mix_columns7 (
                .state(state7_Shift_Rows),
                .mixed_state(state7_Mix_Columns)
            );

            Add_RoundKey add_round_key7 (
                .state(state7_Mix_Columns),
                .round_key(round_key7),
                .state_out(state8)
            );
//8
            Sub_Bytes sub_bytes8 (
                .state(state8),
                .subbed_state(state8_Sub_Bytes)
            );
            Shift_Rows shift_rows8 (
                .state(state8_Sub_Bytes),
                .shifted_state(state8_Shift_Rows)
            );
            Mix_Columns mix_columns8 (
                .state(state8_Shift_Rows),
                .mixed_state(state8_Mix_Columns)
            );

            Add_RoundKey add_round_key8 (
                .state(state8_Mix_Columns),
                .round_key(round_key8),
                .state_out(state9)
            );

    // 最终循环（不包括列混合）
    Sub_Bytes final_sub_bytes (
        .state(state9),
        .subbed_state(state9_Sub_Bytes)
    );
    Shift_Rows final_shift_rows (
        .state(state9_Sub_Bytes),
        .shifted_state(state9_Shift_Rows)
    );
    Add_RoundKey final_add_round_key (
        .state(state9_Shift_Rows),
        .round_key(round_key10), // 最终循环使用最后一个轮密钥
        .state_out(ciphertext)
    );

endmodule