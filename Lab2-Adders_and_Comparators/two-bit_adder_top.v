`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:30:38 01/22/2024
// Design Name:   two_bit_adder
// Module Name:   /media/cse/D6E5-AE1E/CS220Labs/Lab2_1/two-bit_adder/two-bit_adder_top.v
// Project Name:  two-bit_adder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: two_bit_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module two_bit_adder_top;

	// Inputs
	reg [1:0] x;
	reg [1:0] y;

	// Outputs
	wire [1:0] z;
	wire carry;

	// Instantiate the Unit Under Test (UUT)
	two_bit_adder uut (
		.x(x), 
		.y(y), 
		.z(z), 
		.carry(carry)
	);

	initial begin
		// Initialize Inputs
		x = 0;
		y = 0;
       #5;
		 x=1;y=0;
		 #5;
		 x=1;y=1;
		 #5;
		 x=3;y=3;
		// Wait 100 ns for global reset to finish
		#100;
      $finish;
		// Add stimulus here

	end
	initial begin
   $monitor("%d + %d = %d, %d",x,y,z,carry);
	end
endmodule

