module Key_Expansion(
    input wire [127:0] key,            // 原始128位密钥
    output reg [127:0] round_key0,    // 第1个轮密钥
    output reg [127:0] round_key1,    // 第2个轮密钥
    output reg [127:0] round_key2,    // 第3个轮密钥
    output reg [127:0] round_key3,    // 第4个轮密钥
    output reg [127:0] round_key4,    // 第5个轮密钥
    output reg [127:0] round_key5,    // 第6个轮密钥
    output reg [127:0] round_key6,    // 第7个轮密钥
    output reg [127:0] round_key7,    // 第8个轮密钥
    output reg [127:0] round_key8,    // 第9个轮密钥
    output reg [127:0] round_key9,    // 第10个轮密钥
    output reg [127:0] round_key10    // 第11个轮密钥
);

// Rcon值，轮常量
reg [7:0] Rcon[0:9];
initial begin
    Rcon[0] = 8'h01;
    Rcon[1] = 8'h02;
    Rcon[2] = 8'h04;
    Rcon[3] = 8'h08;
    Rcon[4] = 8'h10;
    Rcon[5] = 8'h20;
    Rcon[6] = 8'h40;
    Rcon[7] = 8'h80;
    Rcon[8] = 8'h1B;
    Rcon[9] = 8'h36;
end

// S盒
reg [7:0] Sbox[0:255];
initial begin
    Sbox[8'd0  ]  = 8'h63;
    Sbox[8'd1  ]  = 8'h7c;
    Sbox[8'd2  ]  = 8'h77;
    Sbox[8'd3  ]  = 8'h7b;
    Sbox[8'd4  ]  = 8'hf2;
    Sbox[8'd5  ]  = 8'h6b;
    Sbox[8'd6  ]  = 8'h6f;
    Sbox[8'd7  ]  = 8'hc5;
    Sbox[8'd8  ]  = 8'h30;
    Sbox[8'd9  ]  = 8'h01;
    Sbox[8'd10 ]  = 8'h67;
    Sbox[8'd11 ]  = 8'h2b;
    Sbox[8'd12 ]  = 8'hfe;
    Sbox[8'd13 ]  = 8'hd7;
    Sbox[8'd14 ]  = 8'hab;
    Sbox[8'd15 ]  = 8'h76;
    Sbox[8'd16 ]  = 8'hca;
    Sbox[8'd17 ]  = 8'h82;
    Sbox[8'd18 ]  = 8'hc9;
    Sbox[8'd19 ]  = 8'h7d;
    Sbox[8'd20 ]  = 8'hfa;
    Sbox[8'd21 ]  = 8'h59;
    Sbox[8'd22 ]  = 8'h47;
    Sbox[8'd23 ]  = 8'hf0;
    Sbox[8'd24 ]  = 8'had;
    Sbox[8'd25 ]  = 8'hd4;
    Sbox[8'd26 ]  = 8'ha2;
    Sbox[8'd27 ]  = 8'haf;
    Sbox[8'd28 ]  = 8'h9c;
    Sbox[8'd29 ]  = 8'ha4;
    Sbox[8'd30 ]  = 8'h72;
    Sbox[8'd31 ]  = 8'hc0;
    Sbox[8'd32 ]  = 8'hb7;
    Sbox[8'd33 ]  = 8'hfd;
    Sbox[8'd34 ]  = 8'h93;
    Sbox[8'd35 ]  = 8'h26;
    Sbox[8'd36 ]  = 8'h36;
    Sbox[8'd37 ]  = 8'h3f;
    Sbox[8'd38 ]  = 8'hf7;
    Sbox[8'd39 ]  = 8'hcc;
    Sbox[8'd40 ]  = 8'h34;
    Sbox[8'd41 ]  = 8'ha5;
    Sbox[8'd42 ]  = 8'he5;
    Sbox[8'd43 ]  = 8'hf1;
    Sbox[8'd44 ]  = 8'h71;
    Sbox[8'd45 ]  = 8'hd8;
    Sbox[8'd46 ]  = 8'h31;
    Sbox[8'd47 ]  = 8'h15;
    Sbox[8'd48 ]  = 8'h04;
    Sbox[8'd49 ]  = 8'hc7;
    Sbox[8'd50 ]  = 8'h23;
    Sbox[8'd51 ]  = 8'hc3;
    Sbox[8'd52 ]  = 8'h18;
    Sbox[8'd53 ]  = 8'h96;
    Sbox[8'd54 ]  = 8'h05;
    Sbox[8'd55 ]  = 8'h9a;
    Sbox[8'd56 ]  = 8'h07;
    Sbox[8'd57 ]  = 8'h12;
    Sbox[8'd58 ]  = 8'h80;
    Sbox[8'd59 ]  = 8'he2;
    Sbox[8'd60 ]  = 8'heb;
    Sbox[8'd61 ]  = 8'h27;
    Sbox[8'd62 ]  = 8'hb2;
    Sbox[8'd63 ]  = 8'h75;
    Sbox[8'd64 ]  = 8'h09;
    Sbox[8'd65 ]  = 8'h83;
    Sbox[8'd66 ]  = 8'h2c;
    Sbox[8'd67 ]  = 8'h1a;
    Sbox[8'd68 ]  = 8'h1b;
    Sbox[8'd69 ]  = 8'h6e;
    Sbox[8'd70 ]  = 8'h5a;
    Sbox[8'd71 ]  = 8'ha0;
    Sbox[8'd72 ]  = 8'h52;
    Sbox[8'd73 ]  = 8'h3b;
    Sbox[8'd74 ]  = 8'hd6;
    Sbox[8'd75 ]  = 8'hb3;
    Sbox[8'd76 ]  = 8'h29;
    Sbox[8'd77 ]  = 8'he3;
    Sbox[8'd78 ]  = 8'h2f;
    Sbox[8'd79 ]  = 8'h84;
    Sbox[8'd80 ]  = 8'h53;
    Sbox[8'd81 ]  = 8'hd1;
    Sbox[8'd82 ]  = 8'h00;
    Sbox[8'd83 ]  = 8'hed;
    Sbox[8'd84 ]  = 8'h20;
    Sbox[8'd85 ]  = 8'hfc;
    Sbox[8'd86 ]  = 8'hb1;
    Sbox[8'd87 ]  = 8'h5b;
    Sbox[8'd88 ]  = 8'h6a;
    Sbox[8'd89 ]  = 8'hcb;
    Sbox[8'd90 ]  = 8'hbe;
    Sbox[8'd91 ]  = 8'h39;
    Sbox[8'd92 ]  = 8'h4a;
    Sbox[8'd93 ]  = 8'h4c;
    Sbox[8'd94 ]  = 8'h58;
    Sbox[8'd95 ]  = 8'hcf;
    Sbox[8'd96 ]  = 8'hd0;
    Sbox[8'd97 ]  = 8'hef;
    Sbox[8'd98 ]  = 8'haa;
    Sbox[8'd99 ]  = 8'hfb;
    Sbox[8'd100]  = 8'h43;
    Sbox[8'd101]  = 8'h4d;
    Sbox[8'd102]  = 8'h33;
    Sbox[8'd103]  = 8'h85;
    Sbox[8'd104]  = 8'h45;
    Sbox[8'd105]  = 8'hf9;
    Sbox[8'd106]  = 8'h02;
    Sbox[8'd107]  = 8'h7f;
    Sbox[8'd108]  = 8'h50;
    Sbox[8'd109]  = 8'h3c;
    Sbox[8'd110]  = 8'h9f;
    Sbox[8'd111]  = 8'ha8;
    Sbox[8'd112]  = 8'h51;
    Sbox[8'd113]  = 8'ha3;
    Sbox[8'd114]  = 8'h40;
    Sbox[8'd115]  = 8'h8f;
    Sbox[8'd116]  = 8'h92;
    Sbox[8'd117]  = 8'h9d;
    Sbox[8'd118]  = 8'h38;
    Sbox[8'd119]  = 8'hf5;
    Sbox[8'd120]  = 8'hbc;
    Sbox[8'd121]  = 8'hb6;
    Sbox[8'd122]  = 8'hda;
    Sbox[8'd123]  = 8'h21;
    Sbox[8'd124]  = 8'h10;
    Sbox[8'd125]  = 8'hff;
    Sbox[8'd126]  = 8'hf3;
    Sbox[8'd127]  = 8'hd2;
    Sbox[8'd128]  = 8'hcd;
    Sbox[8'd129]  = 8'h0c;
    Sbox[8'd130]  = 8'h13;
    Sbox[8'd131]  = 8'hec;
    Sbox[8'd132]  = 8'h5f;
    Sbox[8'd133]  = 8'h97;
    Sbox[8'd134]  = 8'h44;
    Sbox[8'd135]  = 8'h17;
    Sbox[8'd136]  = 8'hc4;
    Sbox[8'd137]  = 8'ha7;
    Sbox[8'd138]  = 8'h7e;
    Sbox[8'd139]  = 8'h3d;
    Sbox[8'd140]  = 8'h64;
    Sbox[8'd141]  = 8'h5d;
    Sbox[8'd142]  = 8'h19;
    Sbox[8'd143]  = 8'h73;
    Sbox[8'd144]  = 8'h60;
    Sbox[8'd145]  = 8'h81;
    Sbox[8'd146]  = 8'h4f;
    Sbox[8'd147]  = 8'hdc;
    Sbox[8'd148]  = 8'h22;
    Sbox[8'd149]  = 8'h2a;
    Sbox[8'd150]  = 8'h90;
    Sbox[8'd151]  = 8'h88;
    Sbox[8'd152]  = 8'h46;
    Sbox[8'd153]  = 8'hee;
    Sbox[8'd154]  = 8'hb8;
    Sbox[8'd155]  = 8'h14;
    Sbox[8'd156]  = 8'hde;
    Sbox[8'd157]  = 8'h5e;
    Sbox[8'd158]  = 8'h0b;
    Sbox[8'd159]  = 8'hdb;
    Sbox[8'd160]  = 8'he0;
    Sbox[8'd161]  = 8'h32;
    Sbox[8'd162]  = 8'h3a;
    Sbox[8'd163]  = 8'h0a;
    Sbox[8'd164]  = 8'h49;
    Sbox[8'd165]  = 8'h06;
    Sbox[8'd166]  = 8'h24;
    Sbox[8'd167]  = 8'h5c;
    Sbox[8'd168]  = 8'hc2;
    Sbox[8'd169]  = 8'hd3;
    Sbox[8'd170]  = 8'hac;
    Sbox[8'd171]  = 8'h62;
    Sbox[8'd172]  = 8'h91;
    Sbox[8'd173]  = 8'h95;
    Sbox[8'd174]  = 8'he4;
    Sbox[8'd175]  = 8'h79;
    Sbox[8'd176]  = 8'he7;
    Sbox[8'd177]  = 8'hc8;
    Sbox[8'd178]  = 8'h37;
    Sbox[8'd179]  = 8'h6d;
    Sbox[8'd180]  = 8'h8d;
    Sbox[8'd181]  = 8'hd5;
    Sbox[8'd182]  = 8'h4e;
    Sbox[8'd183]  = 8'ha9;
    Sbox[8'd184]  = 8'h6c;
    Sbox[8'd185]  = 8'h56;
    Sbox[8'd186]  = 8'hf4;
    Sbox[8'd187]  = 8'hea;
    Sbox[8'd188]  = 8'h65;
    Sbox[8'd189]  = 8'h7a;
    Sbox[8'd190]  = 8'hae;
    Sbox[8'd191]  = 8'h08;
    Sbox[8'd192]  = 8'hba;
    Sbox[8'd193]  = 8'h78;
    Sbox[8'd194]  = 8'h25;
    Sbox[8'd195]  = 8'h2e;
    Sbox[8'd196]  = 8'h1c;
    Sbox[8'd197]  = 8'ha6;
    Sbox[8'd198]  = 8'hb4;
    Sbox[8'd199]  = 8'hc6;
    Sbox[8'd200]  = 8'he8;
    Sbox[8'd201]  = 8'hdd;
    Sbox[8'd202]  = 8'h74;
    Sbox[8'd203]  = 8'h1f;
    Sbox[8'd204]  = 8'h4b;
    Sbox[8'd205]  = 8'hbd;
    Sbox[8'd206]  = 8'h8b;
    Sbox[8'd207]  = 8'h8a;
    Sbox[8'd208]  = 8'h70;
    Sbox[8'd209]  = 8'h3e;
    Sbox[8'd210]  = 8'hb5;
    Sbox[8'd211]  = 8'h66;
    Sbox[8'd212]  = 8'h48;
    Sbox[8'd213]  = 8'h03;
    Sbox[8'd214]  = 8'hf6;
    Sbox[8'd215]  = 8'h0e;
    Sbox[8'd216]  = 8'h61;
    Sbox[8'd217]  = 8'h35;
    Sbox[8'd218]  = 8'h57;
    Sbox[8'd219]  = 8'hb9;
    Sbox[8'd220]  = 8'h86;
    Sbox[8'd221]  = 8'hc1;
    Sbox[8'd222]  = 8'h1d;
    Sbox[8'd223]  = 8'h9e;
    Sbox[8'd224]  = 8'he1;
    Sbox[8'd225]  = 8'hf8;
    Sbox[8'd226]  = 8'h98;
    Sbox[8'd227]  = 8'h11;
    Sbox[8'd228]  = 8'h69;
    Sbox[8'd229]  = 8'hd9;
    Sbox[8'd230]  = 8'h8e;
    Sbox[8'd231]  = 8'h94;
    Sbox[8'd232]  = 8'h9b;
    Sbox[8'd233]  = 8'h1e;
    Sbox[8'd234]  = 8'h87;
    Sbox[8'd235]  = 8'he9;
    Sbox[8'd236]  = 8'hce;
    Sbox[8'd237]  = 8'h55;
    Sbox[8'd238]  = 8'h28;
    Sbox[8'd239]  = 8'hdf;
    Sbox[8'd240]  = 8'h8c;
    Sbox[8'd241]  = 8'ha1;
    Sbox[8'd242]  = 8'h89;
    Sbox[8'd243]  = 8'h0d;
    Sbox[8'd244]  = 8'hbf;
    Sbox[8'd245]  = 8'he6;
    Sbox[8'd246]  = 8'h42;
    Sbox[8'd247]  = 8'h68;
    Sbox[8'd248]  = 8'h41;
    Sbox[8'd249]  = 8'h99;
    Sbox[8'd250]  = 8'h2d;
    Sbox[8'd251]  = 8'h0f;
    Sbox[8'd252]  = 8'hb0;
    Sbox[8'd253]  = 8'h54;
    Sbox[8'd254]  = 8'hbb;
    Sbox[8'd255]  = 8'h16; 
end

// 密钥扩展算法
integer i;
reg [127:0] temp_key;
always @(key) begin
    // 初始化轮密钥数组的前四个轮密钥
    round_key0 = key;
    round_key1 = {key[127:112], key[111:96], key[95:80], key[79:64], key[63:48], key[47:32], key[31:16], key[15:0]};
    round_key2 = {key[127:120], key[119:112], key[111:104], key[103:96], key[95:88], key[87:80], key[79:72], key[71:64],
                  key[63:56], key[55:48], key[47:40], key[39:32], key[31:24], key[23:16], key[15:8], key[7:0]};
    round_key3 = {key[127:124], key[123:120], key[119:116], key[115:112], key[111:108], key[107:104], key[103:100], key[99:96],
                  key[95:92], key[91:88], key[87:84], key[83:80], key[79:76], key[75:72], key[71:68], key[67:64]};

    // 扩展剩余的轮密钥
    temp_key = round_key3;
    temp_key = {temp_key[15:0], temp_key[127:120]};
    temp_key[15:8] = Sbox[temp_key[15:8]];
    temp_key[7:0] = Sbox[temp_key[7:0]];
    temp_key[23:16] = Sbox[temp_key[23:16]];
    temp_key[31:24] = Sbox[temp_key[31:24]];
    temp_key[127:120] = temp_key[127:120] ^ Rcon[0];
    round_key4 = round_key0 ^ temp_key;

    temp_key = round_key4;
    temp_key = {temp_key[15:0], temp_key[127:120]};
    temp_key[15:8] = Sbox[temp_key[15:8]];
    temp_key[7:0] = Sbox[temp_key[7:0]];
    temp_key[23:16] = Sbox[temp_key[23:16]];
    temp_key[31:24] = Sbox[temp_key[31:24]];
    temp_key[127:120] = temp_key[127:120] ^ Rcon[1];
    round_key5 = round_key1 ^ temp_key;

    temp_key = round_key5;
    temp_key = {temp_key[15:0], temp_key[127:120]};
    temp_key[15:8] = Sbox[temp_key[15:8]];
    temp_key[7:0] = Sbox[temp_key[7:0]];
    temp_key[23:16] = Sbox[temp_key[23:16]];
    temp_key[31:24] = Sbox[temp_key[31:24]];
    temp_key[127:120] = temp_key[127:120] ^ Rcon[2];
    round_key6 = round_key2 ^ temp_key;

    temp_key = round_key6;
    temp_key = {temp_key[15:0], temp_key[127:120]};
    temp_key[15:8] = Sbox[temp_key[15:8]];
    temp_key[7:0] = Sbox[temp_key[7:0]];
    temp_key[23:16] = Sbox[temp_key[23:16]];
    temp_key[31:24] = Sbox[temp_key[31:24]];
    temp_key[127:120] = temp_key[127:120] ^ Rcon[3];
    round_key7 = round_key3 ^ temp_key;

    temp_key = round_key7;
    temp_key = {temp_key[15:0], temp_key[127:120]};
    temp_key[15:8] = Sbox[temp_key[15:8]];
    temp_key[7:0] = Sbox[temp_key[7:0]];
    temp_key[23:16] = Sbox[temp_key[23:16]];
    temp_key[31:24] = Sbox[temp_key[31:24]];
    temp_key[127:120] = temp_key[127:120] ^ Rcon[4];
    round_key8 = round_key4 ^ temp_key;

    temp_key = round_key8;
    temp_key = {temp_key[15:0], temp_key[127:120]};
    temp_key[15:8] = Sbox[temp_key[15:8]];
    temp_key[7:0] = Sbox[temp_key[7:0]];
    temp_key[23:16] = Sbox[temp_key[23:16]];
    temp_key[31:24] = Sbox[temp_key[31:24]];
    temp_key[127:120] = temp_key[127:120] ^ Rcon[5];
    round_key9 = round_key5 ^ temp_key;

    temp_key = round_key9;
    temp_key = {temp_key[15:0], temp_key[127:120]};
    temp_key[15:8] = Sbox[temp_key[15:8]];
    temp_key[7:0] = Sbox[temp_key[7:0]];
    temp_key[23:16] = Sbox[temp_key[23:16]];
    temp_key[31:24] = Sbox[temp_key[31:24]];
    temp_key[127:120] = temp_key[127:120] ^ Rcon[6];
    round_key10 = round_key6 ^ temp_key;
end

endmodule