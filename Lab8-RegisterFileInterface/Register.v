
`timescale 1ns / 1ps
`define MAX 1000000
//////////////////////////////////////////////////////////////////////////////////

// Company:

// Engineer:

//

// Create Date:    14:01:43 03/18/2024

// Design Name:

// Module Name:    Register

// Project Name:

// Target Devices:

// Tool versions:

// Description:

//

// Dependencies:

//

// Revision:

// Revision 0.01 - File Created

// Additional Comments:

//

//////////////////////////////////////////////////////////////////////////////////
module processor_top(clk, rota, rotb, y, PB, lcd_rs, lcd_w, lcd_e, data);
 

 
input clk, rota, rotb;
 
input [3:0] y;
 
input [2:0] PB;
 
output lcd_rs, lcd_w, lcd_e;
 
output [3:0] data;
 
wire lcd_rs, lcd_w, lcd_e;
 
wire [3:0] data;
 
wire rot_event;
 

 

 
rotor R1(rota, rotb, clk, rot_event);
 
processor P1(clk, rot_event, y, PB, lcd_rs, lcd_w, lcd_e, data);
 
endmodule 


module processor(clk, rot_event, y, PB, lcd_rs, lcd_w, lcd_e, data);

// I/O variables
input clk, rot_event;
input [3:0] y;
input [2:0] PB;
output lcd_rs, lcd_w, lcd_e;
output [3:0] data;
wire lcd_rs, lcd_w, lcd_e;
wire [3:0] data;

// My Register file
reg [15:0] register[0:31];

// Extra Variables needed
reg prev_rot_event = 1;
// Addresses
reg [4:0] RAddr1 = 0;
reg [4:0] RAddr2 = 0;
reg [4:0] WAddr = 0;
// Datas'
reg [15:0] RData1 = 0;
reg [15:0] RData2 = 0;
reg [15:0] WData = 0;

reg [2:0] instruction = 0;
reg [3:0] step = 0;

reg [3:0] shift = 0;

reg [127:0] line1 = "                ";
reg [127:0] line2 = "                ";

initial begin
 register[0] <= 0; register[8] <= 0; register[16] <= 0; register[24] <= 0;
 register[1] <= 0; register[9] <= 0; register[17] <= 0; register[25] <= 0;
 register[2] <= 0; register[10] <= 0; register[18] <= 0; register[26] <= 0;
 register[3] <= 0; register[11] <= 0; register[19] <= 0; register[27] <= 0;
 register[4] <= 0; register[12] <= 0; register[20] <= 0; register[28] <= 0;
 register[5] <= 0; register[13] <= 0; register[21] <= 0; register[29] <= 0;
 register[6] <= 0; register[14] <= 0; register[22] <= 0; register[30] <= 0;
 register[7] <= 0; register[15] <= 0; register[23] <= 0; register[31] <= 0;
end

// Now the main execution
always @(posedge clk) begin

 if(PB[1]) step<=0;

 // To Select the instruction to be given
 if(PB[0]) instruction <= y[2:0];

 // To Restart the whole process (or) RESET the resister_file
 if(PB[2]) begin
 register[0] <= 0; register[8] <= 0; register[16] <= 0; register[24] <= 0;
 register[1] <= 0; register[9] <= 0; register[17] <= 0; register[25] <= 0;
 register[2] <= 0; register[10] <= 0; register[18] <= 0; register[26] <= 0;
 register[3] <= 0; register[11] <= 0; register[19] <= 0; register[27] <= 0;
 register[4] <= 0; register[12] <= 0; register[20] <= 0; register[28] <= 0;
 register[5] <= 0; register[13] <= 0; register[21] <= 0; register[29] <= 0;
 register[6] <= 0; register[14] <= 0; register[22] <= 0; register[30] <= 0;
 register[7] <= 0; register[15] <= 0; register[23] <= 0; register[31] <= 0;
 end
 if(~prev_rot_event & rot_event) begin
 case(instruction)
 0: begin
 case(step)
 0: begin
 WAddr[3:0] <= y;
 step <= step + 1;
 end
 1: begin
 WAddr[4] <= y[0];
 step <= step + 1;
 end
 2: begin
 WData[3:0] <= y;
 step <= step + 1;
 end
 3: begin
 WData[7:4] <= y;
 step <= step + 1;
 end
 4: begin
 WData[11:8] <= y;
 step <= step + 1;
 end
 5: begin
 WData[15:12] <= y;
 step <= step + 1;
 end
 6: begin
 register[WAddr] <= WData;
 step <= step + 1;
 end
 7: begin
 line1[127:120] <= WAddr[4] + 48;
 line1[119:112] <= WAddr[3] + 48;
 line1[111:104] <= WAddr[2] + 48;
 line1[103:96] <= WAddr[1] + 48;
 line1[95:88] <= WAddr[0] + 48;
 line1[87:0] <= "           ";

 line2[127:120] <= WData[15] + 48; line2[63:56] <= WData[7] + 48;
 line2[119:112] <= WData[14] + 48; line2[55:48] <= WData[6] + 48;
 line2[111:104] <= WData[13] + 48; line2[47:40] <= WData[5] + 48;
 line2[103:96] <= WData[12] + 48; line2[39:32] <= WData[4] + 48;
 line2[95:88] <= WData[11] + 48; line2[31:24] <= WData[3] + 48;
 line2[87:80] <= WData[10] + 48; line2[23:16] <= WData[2] + 48;
 line2[79:72] <= WData[9] + 48; line2[15:8] <= WData[1] + 48;
 line2[71:64] <= WData[8] + 48; line2[7:0] <= WData[0] + 48;
 step <= 0;
 end
 endcase
 end
 1: begin
 case(step)
 0: begin
 RAddr1[3:0] <= y;
 step <= step + 1;
 end
 1: begin
 RAddr1[4] <= y[0];
 step <= step + 1;
 end
 2: begin
 RData1 <= register[RAddr1];
 step <= step + 1;
 end
 3: begin

 line1[127:120] <= RAddr1[4] + 48;
 line1[119:112] <= RAddr1[3] + 48;
 line1[111:104] <= RAddr1[2] + 48;
 line1[103:96] <= RAddr1[1] + 48;
 line1[95:88] <= RAddr1[0] + 48;
 line1[87:0] <= "           ";

 line2[127:120] <= RData1[15] + 48; line2[63:56] <= RData1[7] + 48;
 line2[119:112] <= RData1[14] + 48; line2[55:48] <= RData1[6] + 48;
 line2[111:104] <= RData1[13] + 48; line2[47:40] <= RData1[5] + 48;
 line2[103:96] <= RData1[12] + 48; line2[39:32] <= RData1[4] + 48;
 line2[95:88] <= RData1[11] + 48; line2[31:24] <= RData1[3] + 48;
 line2[87:80] <= RData1[10] + 48; line2[23:16] <= RData1[2] + 48;
 line2[79:72] <= RData1[9] + 48; line2[15:8] <= RData1[1] + 48;
 line2[71:64] <= RData1[8] + 48; line2[7:0] <= RData1[0] + 48;
 step <= 0;
 end
 endcase
 end
 2: begin
 case(step)
 0: begin
 RAddr1[3:0] <= y;
 step <= step + 1;
 end
 1: begin
 RAddr1[4] <= y[0];
 step <= step + 1;
 end
 2: begin
 RAddr2[3:0] <= y;
 step <= step + 1;
 end
 3: begin
 RAddr2[4] <= y[0];
 step <= step + 1;
 end
 4: begin
 RData1 <= register[RAddr1];
 RData2 <= register[RAddr2];
 step <= step + 1;
 end
 5: begin

 line1[127:120] <= RData1[15] + 48; line1[63:56] <= RData1[7] + 48;
 line1[119:112] <= RData1[14] + 48; line1[55:48] <= RData1[6] + 48;
 line1[111:104] <= RData1[13] + 48; line1[47:40] <= RData1[5] + 48;
 line1[103:96] <= RData1[12] + 48; line1[39:32] <= RData1[4] + 48;
 line1[95:88] <= RData1[11] + 48; line1[31:24] <= RData1[3] + 48;
 line1[87:80] <= RData1[10] + 48; line1[23:16] <= RData1[2] + 48;
 line1[79:72] <= RData1[9] + 48; line1[15:8] <= RData1[1] + 48;
 line1[71:64] <= RData1[8] + 48; line1[7:0] <= RData1[0] + 48;

 line2[127:120] <= RData2[15] + 48; line2[63:56] <= RData2[7] + 48;
 line2[119:112] <= RData2[14] + 48; line2[55:48] <= RData2[6] + 48;
 line2[111:104] <= RData2[13] + 48; line2[47:40] <= RData2[5] + 48;
 line2[103:96] <= RData2[12] + 48; line2[39:32] <= RData2[4] + 48;
 line2[95:88] <= RData2[11] + 48; line2[31:24] <= RData2[3] + 48;
 line2[87:80] <= RData2[10] + 48; line2[23:16] <= RData2[2] + 48;
 line2[79:72] <= RData2[9] + 48; line2[15:8] <= RData2[1] + 48;
 line2[71:64] <= RData2[8] + 48; line2[7:0] <= RData2[0] + 48;
 step <= 0;
 end
 endcase
 end
 3: begin
 case(step)
 0: begin
 RAddr1[3:0] <= y;
 step <= step + 1;
 end
 1: begin
 RAddr1[4] <= y[0];
 step <= step + 1;
 end
 2: begin
 WAddr[3:0] <= y;
 step <= step + 1;
 end
 3: begin
 WAddr[4] <= y[0];
 step <= step + 1;
 end
 4: begin
 WData[3:0] <= y;
 step <= step + 1;
 end
 5: begin
 WData[7:4] <= y;
 step <= step + 1;
 end
 6: begin
 WData[11:8] <= y;
 step <= step + 1;
 end
 7: begin
 WData[15:12] <= y;
 step <= step + 1;
 end
 8: begin
 RData1 <= register[RAddr1];
 register[WAddr] <= WData;
 step <= step + 1;
 end
 9: begin

 line1[127:120] <= RAddr1[4] + 48;
 line1[119:112] <= RAddr1[3] + 48;
 line1[111:104] <= RAddr1[2] + 48;
 line1[103:96] <= RAddr1[1] + 48;
 line1[95:88] <= RAddr1[0] + 48;
 line1[87:0] <= "           ";

 line2[127:120] <= RData1[15] + 48; line2[63:56] <= RData1[7] + 48;
 line2[119:112] <= RData1[14] + 48; line2[55:48] <= RData1[6] + 48;
 line2[111:104] <= RData1[13] + 48; line2[47:40] <= RData1[5] + 48;
 line2[103:96] <= RData1[12] + 48; line2[39:32] <= RData1[4] + 48;
 line2[95:88] <= RData1[11] + 48; line2[31:24] <= RData1[3] + 48;
 line2[87:80] <= RData1[10] + 48; line2[23:16] <= RData1[2] + 48;
 line2[79:72] <= RData1[9] + 48; line2[15:8] <= RData1[1] + 48;
 line2[71:64] <= RData1[8] + 48; line2[7:0] <= RData1[0] + 48;
 step <= 0;
 end
 endcase
 end
 4: begin
 case(step)
 0: begin
 RAddr1[3:0] <= y;
 step <= step + 1;
 end
 1: begin
 RAddr1[4] <= y[0];
 step <= step + 1;
 end
 2: begin
 RAddr2[3:0] <= y;
 step <= step + 1;
 end
 3: begin
 RAddr2[4] <= y[0];
 step <= step + 1;
 end
 4: begin
 WAddr[3:0] <= y;
 step <= step + 1;
 end
 5: begin
 WAddr[4] <= y[0];
 step <= step + 1;
 end
 6: begin
 WData[3:0] <= y;
 step <= step + 1;
 end
 7: begin
 WData[7:4] <= y;
 step <= step + 1;
 end
 8: begin
 WData[11:8] <= y;
 step <= step + 1;
 end
 9: begin
 WData[15:12] <= y;
 step <= step + 1;
 end
 10: begin
 register[WAddr] <= WData;

 RData1 <= register[RAddr1];
 RData2 <= register[RAddr2];
 step <= step + 1;
 end
 11: begin

 line1[127:120] <= RData1[15] + 48; line1[63:56] <= RData1[7] + 48;
 line1[119:112] <= RData1[14] + 48; line1[55:48] <= RData1[6] + 48;
 line1[111:104] <= RData1[13] + 48; line1[47:40] <= RData1[5] + 48;
 line1[103:96] <= RData1[12] + 48; line1[39:32] <= RData1[4] + 48;
 line1[95:88] <= RData1[11] + 48; line1[31:24] <= RData1[3] + 48;
 line1[87:80] <= RData1[10] + 48; line1[23:16] <= RData1[2] + 48;
 line1[79:72] <= RData1[9] + 48; line1[15:8] <= RData1[1] + 48;
 line1[71:64] <= RData1[8] + 48; line1[7:0] <= RData1[0] + 48;

 line2[127:120] <= RData2[15] + 48; line2[63:56] <= RData2[7] + 48;
 line2[119:112] <= RData2[14] + 48; line2[55:48] <= RData2[6] + 48;
 line2[111:104] <= RData2[13] + 48; line2[47:40] <= RData2[5] + 48;
 line2[103:96] <= RData2[12] + 48; line2[39:32] <= RData2[4] + 48;
 line2[95:88] <= RData2[11] + 48; line2[31:24] <= RData2[3] + 48;
 line2[87:80] <= RData2[10] + 48; line2[23:16] <= RData2[2] + 48;
 line2[79:72] <= RData2[9] + 48; line2[15:8] <= RData2[1] + 48;
 line2[71:64] <= RData2[8] + 48; line2[7:0] <= RData2[0] + 48;
 step <= 0;
 end
 endcase
 end
 5: begin
 case(step)
 0: begin
 RAddr1[3:0] <= y;
 step <= step + 1;
 end
 1: begin
 RAddr1[4] <= y[0];
 step <= step + 1;
 end
 2: begin
 RAddr2[3:0] <= y;
 step <= step + 1;
 end
 3: begin
 RAddr2[4] <= y[0];
 RData1 <= register[RAddr1];
 step <= step + 1;
 end
 4: begin
 WAddr[3:0] <= y;

 RData2 <= register[RAddr2];
 step <= step + 1;
 end
 5: begin
 WAddr[4] <= y[0];
 if($signed(RData1) < $signed(RData2)) WData <= 1;
 else WData <= 0;
 step <= step + 1;
 end
 6: begin

 register[WAddr] <= WData;

 line1[127:120] <= WAddr[4] + 48;
 line1[119:112] <= WAddr[3] + 48;
 line1[111:104] <= WAddr[2] + 48;
 line1[103:96] <= WAddr[1] + 48;
 line1[95:88] <= WAddr[0] + 48;
 line1[87:0] <= "           ";

 line2[127:120] <= WData[15] + 48; line2[63:56] <= WData[7] + 48;
 line2[119:112] <= WData[14] + 48; line2[55:48] <= WData[6] + 48;
 line2[111:104] <= WData[13] + 48; line2[47:40] <= WData[5] + 48;
 line2[103:96] <= WData[12] + 48; line2[39:32] <= WData[4] + 48;
 line2[95:88] <= WData[11] + 48; line2[31:24] <= WData[3] + 48;
 line2[87:80] <= WData[10] + 48; line2[23:16] <= WData[2] + 48;
 line2[79:72] <= WData[9] + 48; line2[15:8] <= WData[1] + 48;
 line2[71:64] <= WData[8] + 48; line2[7:0] <= WData[0] + 48;
 step <= 0;
 end
 endcase
 end
 6: begin
 case(step)
 0: begin
 RAddr1[3:0] <= y;
 step <= step + 1;
 end
 1: begin
 RAddr1[4] <= y[0];
 step <= step + 1;
 end
 2: begin
 RData1 <= register[RAddr1];
 RAddr2[3:0] <= y;
 step <= step + 1;
 end
 3: begin
 RAddr2[4] <= y[0];
 step <= step + 1;
 end
 4: begin
 RData2 <= register[RAddr2];
 WAddr[3:0] <= y;
 step <= step + 1;
 end
 5: begin
 WAddr[4] <= y[0];
 WData <= RData1 ^ RData2;
 step <= step + 1;
 end
 6: begin

 register[WAddr] <= WData;

 line1[127:120] <= WAddr[4] + 48;
 line1[119:112] <= WAddr[3] + 48;
 line1[111:104] <= WAddr[2] + 48;
 line1[103:96] <= WAddr[1] + 48;
 line1[95:88] <= WAddr[0] + 48;
 line1[87:0] <= "           ";

 line2[127:120] <= WData[15] + 48; line2[63:56] <= WData[7] + 48;
 line2[119:112] <= WData[14] + 48; line2[55:48] <= WData[6] + 48;
 line2[111:104] <= WData[13] + 48; line2[47:40] <= WData[5] + 48;
 line2[103:96] <= WData[12] + 48; line2[39:32] <= WData[4] + 48;
 line2[95:88] <= WData[11] + 48; line2[31:24] <= WData[3] + 48;
 line2[87:80] <= WData[10] + 48; line2[23:16] <= WData[2] + 48;
 line2[79:72] <= WData[9] + 48; line2[15:8] <= WData[1] + 48;
 line2[71:64] <= WData[8] + 48; line2[7:0] <= WData[0] + 48;
 step <= 0;
 end
 endcase
 end
 7: begin
 case(step)
 0: begin
 RAddr1[3:0] <= y;
 step <= step + 1;
 end
 1: begin
 RAddr1[4] <= y[0];
 step <= step + 1;
 end
 2: begin
 WAddr[3:0] <= y;
 RData1 <= register[RAddr1];
 step <= step + 1;
 end
 3: begin
 WAddr[4] <= y[0];
 step <= step + 1;
 end
 4: begin
 shift <= y;
 step <= step + 1;
 end
 5: begin
 WData <= $signed(RData1) << shift;
 step <= step + 1;
 end
 6: begin

 register[WAddr] <= WData;

 line1[127:120] <= WAddr[4] + 48;
 line1[119:112] <= WAddr[3] + 48;
 line1[111:104] <= WAddr[2] + 48;
 line1[103:96] <= WAddr[1] + 48;
 line1[95:88] <= WAddr[0] + 48;
 line1[87:0] <= "           ";

 line2[127:120] <= WData[15] + 48; line2[63:56] <= WData[7] + 48;
 line2[119:112] <= WData[14] + 48; line2[55:48] <= WData[6] + 48;
 line2[111:104] <= WData[13] + 48; line2[47:40] <= WData[5] + 48;
 line2[103:96] <= WData[12] + 48; line2[39:32] <= WData[4] + 48;
 line2[95:88] <= WData[11] + 48; line2[31:24] <= WData[3] + 48;
 line2[87:80] <= WData[10] + 48; line2[23:16] <= WData[2] + 48;
 line2[79:72] <= WData[9] + 48; line2[15:8] <= WData[1] + 48;
 line2[71:64] <= WData[8] + 48; line2[7:0] <= WData[0] + 48;
 step <= 0;
 end
 endcase
 end
 endcase
 end

 prev_rot_event <= rot_event;
end

lcd_driver L1(line1, line2, clk, lcd_rs, lcd_w, lcd_e, data);

endmodule



module lcd_driver(line1, line2, clk, lcd_rs, lcd_w, lcd_e, data);
 

 
input [127:0] line1;
 
input [127:0] line2;
 
input clk;
 
output lcd_rs, lcd_w, lcd_e;
 
output [3:0] data;
 
reg lcd_rs, lcd_w, lcd_e;
 
reg [3:0] data;
 
reg [20:0] counter = 21'b0;
 
reg [1:0] step = 2'b01;
 
reg [4:0] state = 5'b0;
 
reg [1:0] linechange = 2'b0;
 
reg [7:0] pos = 127;
 
reg [3:0] db;
 

 
always @(posedge clk) begin
 
if((counter == `MAX)) begin
 
if(step == 2'b01) begin
 
lcd_e  <= 1'b0;
 
step  <= step + 1;
 
end
 
else if(step == 2'b11) begin
 
lcd_e  <= 1'b1;
 
step  <= 2'b01;
 
end
 
else if(step == 2'b10) begin
 
case(state)
 
0: begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h3;
 
state  <= state + 1;
 
end
 
1: begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h3;
 
state  <= state + 1;
 
end
 
2: begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h3;
 
state  <= state + 1;
 
end
 
3: begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h2;
 
state  <= state + 1;
 
end
 
4: begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h2;
 
state  <= state + 1;
 
end
 
5: begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h8;
 
state  <= state + 1;
 
end
 
6: begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h0;
 
state  <= state + 1;
 
end
 
7: begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h6;
 
state  <= state + 1;
 
end
 
8: begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h0;
 
state  <= state + 1;
 
end
 
9: begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'hC;
 
state  <= state + 1;
 
end
 
10: begin  
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h0;
 
state  <= state + 1;
 
end
 
11: begin  
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h1;
 
state  <= state + 1;
 
end
 
12: begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h8;
 
state  <= state + 1;
 
end
 
13: begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h0;
 
state  <= state + 1;
 
end
 
14: begin
 
if(linechange == 0) begin
 
db = line1[pos-:4];
 
lcd_rs  <= 1'b1;
 
lcd_w  <= 1'b0;
 
data  <= db[3:0];
 
if(pos == 3) begin
 
pos  <= 127;
 
linechange  <= linechange + 1;
 
end
 
else pos  <= pos - 4;
 
end
 
 
 
if(linechange == 1) begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'hC;
 
linechange  <= linechange + 1;
 
 
 
end
 
 
 
if(linechange == 2) begin
 
lcd_rs  <= 1'b0;
 
lcd_w  <= 1'b0;
 
data  <= 4'h0;
 
linechange  <= linechange + 1;
 
 
 
end
 
 
 
if(linechange == 3) begin
 
db = line2[pos-:4];
 
lcd_rs  <= 1'b1;
 
lcd_w  <= 1'b0;
 
data  <= db[3:0];
 
if(pos == 3) begin
 
state  <= 0;
 
step  <= 1;
 
linechange  <= 0;
 
counter  <= 0;
 
pos  <= 127;
 

 
end
 
else pos  <= pos - 4;
 
end
 
 
 
end
 
endcase
 

 

 
step  <= step + 1;
 
end
 
counter  <= 21'b0;
 
end
 
else
 
counter  <= counter + 1;
 
end
 

 
endmodule
 
 
module rotor(rota, rotb, clk, rot_event);
 

 
input rota, rotb, clk;
 
output    rot_event;
 
reg rot_event = 0;
 

 
always @(posedge clk) begin
 
if(rota  &  rotb)
 
rot_event  <= 1;
 
else if(~rota  &  ~rotb)
 
rot_event  <= 0;
 
end
 

 
endmodule

 

 

 
 
 