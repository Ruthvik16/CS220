`timescale 1ns / 1ps

`define OUTPUTREG 2
`define MAXPC 14
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:11:54 04/15/2024 
// Design Name: 
// Module Name:    mips 
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


module mips(clk,led);
input clk;
output wire [7:0]led;
reg [7:0] finalled;
reg [31:0]mem[0:13];
reg [7:0]dram[0:10];
reg [7:0]reg_file[0:31];
reg [7:0] PC;
reg [3:0]state=0;
initial begin
    mem[0] = 32'b00100100000000100000000000000000;
    mem[1] = 32'b00100100000000110000000000000000;
    mem[2] = 32'b00000000011000010010000000101010;
    mem[3] = 32'b00010000000001000000000000001000;
    mem[4] = 32'b00100100000001010000000000001010;
    mem[5] = 32'b00010000101000110000000000000110;
    mem[6] = 32'b10001100011001100000000000000000;
    mem[7] = 32'b00000000010001100001000000100001;
    mem[8] = 32'b00100100011000110000000000000001;
    mem[9] = 32'b00000000011000010010000000101010;
    mem[10] = 32'b00010100000001001111111111111011;
    mem[11] = 32'b00000011111000000000000000001000;
    mem[12] = 32'b10001100000000010000000000001010;
    mem[13] = 32'b00001100000000000000000000000000;
end
initial begin
    dram[0] = 8'd1;
    dram[1] = 8'd2;
    dram[2] = 8'd3;
    dram[3] = 8'd4;
    dram[4] = 8'd5;
    dram[5] = 8'd6;
    dram[6] = 8'd7;
    dram[7] = 8'd8;
    dram[8] = 8'd9;
    dram[9] = 8'd10;
    dram[10] = 8'd11;
end
initial begin
 reg_file[0] = 8'd0; 
 reg_file[1] = 8'd0; 
 reg_file[2] = 8'd0; 
 reg_file[3] = 8'd0;
 reg_file[4] = 8'd0; 
 reg_file[5] = 8'd0; 
 reg_file[6] = 8'd0; 
 reg_file[7] = 8'd0;
 reg_file[8] = 8'd0; 
 reg_file[9] = 8'd0; 
 reg_file[10] = 8'd0; 
 reg_file[11] = 8'd0;
 reg_file[12] = 8'd0; 
 reg_file[13] = 8'd0; 
 reg_file[14] = 8'd0; 
 reg_file[15] = 8'd0;
 reg_file[16] = 8'd0; 
 reg_file[17] = 8'd0; 
 reg_file[18] = 8'd0; 
 reg_file[19] = 8'd0;
 reg_file[20] = 8'd0;
 reg_file[21] = 8'd0; 
 reg_file[22] = 8'd0; 
 reg_file[23] = 8'd0;
 reg_file[24] = 8'd0; 
 reg_file[25] = 8'd0; 
 reg_file[26] = 8'd0; 
 reg_file[27] = 8'd0;
 reg_file[28] = 8'd0; 
 reg_file[29] = 8'd0; 
 reg_file[30] = 8'd0; 
 reg_file[31] = 8'd0;

 PC = 8'd12;
end
reg [31:0] instruction;
reg [4:0] rs;
reg [4:0] rt;
reg [4:0] rd;
reg [5:0] func;
reg [15:0] immediate;
reg [25:0] jump_target;
reg [7:0] rs_data;
reg [7:0] rt_data;
reg [7:0] rd_data;
reg [7:0] result;
reg [5:0] opcode;
reg valid;
reg [4:0]addr;
always @(posedge clk) begin
    if(state == 0) begin
        instruction[31:0] = mem[PC];
        state = 1;
    end
    else if(state == 1) begin
        opcode[5:0] = instruction[31:26];
        rs[4:0] = instruction[25:21];
        rt[4:0] = instruction[20:16];
        rd[4:0] = instruction[15:11];
        func[5:0] = instruction[5:0];
        jump_target[25:0] = instruction[25:0];
        immediate[15:0] = instruction[15:0];
        state = 2;
    end
    else if(state == 2) begin
        rs_data[7:0] = reg_file[rs];
        rt_data[7:0] = reg_file[rt];
        state = 3;
    end
    else if(state == 3) begin
        if(opcode == 6'h0) begin  
            if(func[5:0] == 6'h2a) begin  
                result = ($signed(rs_data) < $signed(rt_data)) ? 8'd1 : 8'd0;
                PC = PC + 1;
                valid = 1;
            end
            else if(func[5:0] == 6'h21) begin  
                result = rs_data + rt_data;
                PC = PC + 1;
                valid = 1;
            end
            else if(func[5:0] == 6'h8) begin   
                valid = 0;
                PC = rs_data;
            end
            else begin
                valid = 0;
                PC = PC + 1;
            end
        end
        else if(opcode == 6'h9) begin    
            result[7:0] = rs_data[7:0] + immediate[7:0];
            valid = 1;
            PC = PC + 1;
        end
        else if(opcode == 6'h4) begin  
            PC = PC + ((rs_data == rt_data) ? immediate[7:0] : 1);
            valid = 0;
        end
        else if(opcode == 6'h23) begin   
            addr = immediate[4:0]+rs_data[4:0];
            PC = PC + 1;
            valid = 1;
        end
        else if(opcode == 6'h3) begin  
            reg_file[31] = PC + 1;
            PC = jump_target[7:0];
            valid = 0;
        end
        else if(opcode == 6'h5) begin 
            PC = PC + ((rs_data == rt_data) ? 1 : immediate[7:0]);
            valid = 0;
        end
        else begin
            valid = 0;
            PC = PC + 1;
        end
        state = 4;
    end
    else if(state == 4) begin     
        if(opcode == 6'h23) begin
            result[7:0] = dram[addr];
        end
        state = 5;
    end
    else if(state == 5) begin
        if(valid==1) begin
            if(opcode == 6'h0 && rd!=0) begin   
                reg_file[rd] = result;
            end
            else if (rt!=0) begin
                reg_file[rt] = result;
            end
        end
        if(PC < `MAXPC) begin
            state=0;
        end
        else begin
            state = 6;
        end
    end
    else if(state == 6) begin
        finalled[7:0] = reg_file[`OUTPUTREG];
    end
    
end
assign led = finalled;

endmodule
