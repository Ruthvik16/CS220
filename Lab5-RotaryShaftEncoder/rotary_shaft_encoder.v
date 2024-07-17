`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:41 02/12/2024 
// Design Name: 
// Module Name:    rotart_shaft_encoder 
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

module top(clk, ROT_A, ROT_B,led0, led1, led2, led3, led4, led5, led6, led7);
input clk;
input ROT_A;
input ROT_B;
output led0;
	 wire led0 ;
	 output led1;
	 wire led1 ;
	 output led2;
	 wire  led2 ;
	 output led3;
	 wire  led3 ;
	 output led4;
	 wire  led4 ;
	 output led5;
	 wire  led5 ;
	 output led6;
	 wire  led6 ;
	 output led7;
	 wire  led7 ;
	 
wire rotation_event;
wire rotation_direction;

rotary_shaft_encoder uut (clk, ROT_A, ROT_B,rotation_event, rotation_direction);	
led_rippler uur(clk, rotation_event, rotation_direction,led0, led1, led2, led3, led4, led5, led6, led7);

endmodule

module rotary_shaft_encoder(clk, ROT_A, ROT_B,rotation_event, rotation_direction);
input clk;
input ROT_A;
input ROT_B;
output rotation_event;
reg rotation_event;
output rotation_direction;
reg rotation_direction;

always@(posedge clk) begin
if(ROT_A==1 & ROT_B==1)begin
rotation_event<=1;
end

if(ROT_A==0 & ROT_B==0)begin
rotation_event<=0;
end

if(ROT_A==0 & ROT_B==1)begin
//Roateted to the left
rotation_direction<=1;
end

if(ROT_A==1 & ROT_B==0)begin
//Roateted to the right
rotation_direction<=0;
end
end

endmodule



module led_rippler(clk, rotation_event, rotation_direction,led0, led1, led2, led3, led4, led5, led6, led7);
input clk;
input rotation_event;
input rotation_direction;
	 output led0;
	 reg led0 = 1;
	 output led1;
	 reg led1 = 0;
	 output led2;
	 reg led2 = 0;
	 output led3;
	 reg led3 = 0;
	 output led4;
	 reg led4 = 0;
	 output led5;
	 reg led5 = 0;
	 output led6;
	 reg led6 = 0;
	 output led7;
	 reg led7 = 0;
reg prev_rotation_event;
initial begin
prev_rotation_event<=1;
end

always@(posedge clk) begin



if(prev_rotation_event==0 & rotation_event==1) begin
	if(rotation_direction==0) begin
	 led0 <= led1;
	 led1 <= led2;
	 led2 <= led3;
	 led3 <= led4;
	 led4 <= led5;
	 led5 <= led6;
	 led6 <= led7;
	 led7 <= led0;
	end
	if(rotation_direction==1) begin
	 led1 <= led0;
	 led2 <= led1;
	 led3 <= led2;
	 led4 <= led3;
	 led5 <= led4;
	 led6 <= led5;
	 led7 <= led6;
	 led0 <= led7;
	end
end

prev_rotation_event <= rotation_event;


end
endmodule
