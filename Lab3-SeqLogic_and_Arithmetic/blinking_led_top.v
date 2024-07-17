`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:14:04 02/05/2024
// Design Name:   blinking_led
// Module Name:   /home/cse/Desktop/blinking_led/blinking_led_top.v
// Project Name:  blinking_led
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: blinking_led
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`define OFF_TIME 25000000
`define ON_TIME (`OFF_TIME*2)
module blinking_led_top;

	// Inputs
	reg clk;

	// Outputs
	wire led;

	// Instantiate the Unit Under Test (UUT)
	blinking_led uut (
		.clk(clk), 
		.led(led)
	);

	initial begin
	forever begin
		// Initialize Inputs
		clk <= 0;
      #1;
		clk <= 1;
		#1;
		clk <= 0;
	end
	end
	always@(led) begin
	$display("time=%d led=%b",$time,led);
	end
	initial begin
	#(20*`OFF_TIME) 
	$finish;
	end
      
endmodule

