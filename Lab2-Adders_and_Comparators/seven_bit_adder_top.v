`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:20:05 01/29/2024
// Design Name:   seven_bit_adder
// Module Name:   /media/cse/D6E5-AE1E/CS220Labs/Lab2_2/seven_bit_adder/seven_bit_adder_top.v
// Project Name:  seven_bit_adder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: seven_bit_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module seven_bit_adder_top;

	// Inputs
	reg PB1;
	reg PB2;
	reg PB3;
	reg PB4;
	reg [3:0] a;
	wire  [6:0] z;

	// Outputs
	wire carry;

	// Instantiate the Unit Under Test (UUT)
	seven_bit_adder uut (
		.PB1(PB1), 
		.PB2(PB2), 
		.PB3(PB3), 
		.PB4(PB4), 
		.a(a), 
		.z(z), 
		.carry(carry)
	);

		always@(z or carry) begin
		$display("time=%d: sum = %b, carry = %b\n", $time,z,carry);
		end
		initial begin
		#40
		$finish;
		end
		
		initial begin
		PB1= 1'b1; a[3:0]=4'b1111;
		#4;
		PB2= 1'b1; a[2:0] = 3'b111;
		#4;
      PB3=1'b1; a[3:0]= 4'b0001;
		#4;
      PB4=1'b1; a[2:0]= 3'b000;		
		end
		
endmodule

