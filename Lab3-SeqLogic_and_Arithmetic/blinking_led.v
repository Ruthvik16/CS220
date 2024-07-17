`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:00:56 02/05/2024 
// Design Name: 
// Module Name:    blinking_led 
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
`define OFF_TIME 25000000
`define ON_TIME (`OFF_TIME*2)
module blinking_led(clk, led);
input clk;
output led;
reg led;
reg [31:0] count;
initial begin
led<=1'b1;
count<=0;
end

always @(posedge clk) begin
count<=count+1;
if(count==`OFF_TIME) begin
led<=1'b0;
end
else if(count==`ON_TIME) begin
led<=1'b1;
count<=0;
end
end

endmodule
