`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:33:03 01/29/2024 
// Design Name: 
// Module Name:    eight_bit_comparator 
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
module single_bit(a,b,lesser_p,greater_p,equal_p,lesser_n,greater_n,equal_n);
input a;
input b;
input lesser_p;
input greater_p;
input equal_p;

output lesser_n;
wire lesser_n;
output greater_n;
wire greater_n;
output equal_n;
wire equal_n;

assign greater_n =  (greater_p|((~lesser_p & b & ~a)) & equal_p);
assign lesser_n = (lesser_p| ((~greater_p & ~b & a)) & equal_p);
assign equal_n = ( equal_p & ((a&b)|(~a&~b)));
endmodule

module eight_bit_comparator(PB1,PB2,PB3,PB4,switch_input,lesser,greater,equal);
input PB1;
input PB2;
input PB3;
input PB4;
input [3:0]switch_input;
reg [7:0]a;
reg [7:0]b;
output [7:0]lesser;
wire [7:0] lesser;
output [7:0]greater;
wire [7:0] greater;


output [7:0]equal;
wire [7:0] equal;

always@(posedge PB1) begin
	a[3:0]<=switch_input[3:0];
end
always@(posedge PB2) begin
	a[7:4]<=switch_input[3:0];
end
always@(posedge PB3) begin
	b[3:0]<=switch_input[3:0];
end
always@(posedge PB4) begin
	b[7:4]<=switch_input[3:0];
end

single_bit SB0 (a[7],b[7],1'b0,1'b0,1'b1,lesser[7],greater[7],equal[7]);
single_bit SB1 (a[6],b[6],lesser[7],greater[7],equal[7],lesser[6],greater[6],equal[6]);
single_bit SB2 (a[5],b[5],lesser[6],greater[6],equal[6],lesser[5],greater[5],equal[5]);
single_bit SB3 (a[4],b[4],lesser[5],greater[5],equal[5],lesser[4],greater[4],equal[4]);
single_bit SB4 (a[3],b[3],lesser[4],greater[4],equal[4],lesser[3],greater[3],equal[3]);
single_bit SB5 (a[2],b[2],lesser[3],greater[3],equal[3],lesser[2],greater[2],equal[2]);
single_bit SB6 (a[1],b[1],lesser[2],greater[2],equal[2],lesser[1],greater[1],equal[1]);
single_bit SB7 (a[0],b[0],lesser[1],greater[1],equal[1],lesser[0],greater[0],equal[0]);
endmodule
