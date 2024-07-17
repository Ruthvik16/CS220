`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:06:36 01/29/2024
// Design Name:   eight_bit_comparator
// Module Name:   /home/cse/Desktop/eight_bit_comparator/eight_bit_comparator_top.v
// Project Name:  eight_bit_comparator
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: eight_bit_comparator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module eight_bit_comparator_top;

	// Inputs
	reg PB1;
	reg PB2;
	reg PB3;
	reg PB4;
	reg [3:0] switch_input;

	// Outputs
	wire [7:0] lesser;
	wire [7:0] greater;
	wire [7:0] equal;

	// Instantiate the Unit Under Test (UUT)
	eight_bit_comparator uut (
		.PB1(PB1), 
		.PB2(PB2), 
		.PB3(PB3), 
		.PB4(PB4), 
		.switch_input(switch_input), 
		.lesser(lesser), 
		.greater(greater), 
		.equal(equal)
	);

	always @(equal[0] or greater[0] or lesser[0])
 begin
   $display("time=%d: equal = %b, greater = %b, lesser = %b\n",$time,equal[0], greater[0], lesser[0]);   
 end

	initial begin
		#50
		$finish;
	end
 
initial begin 
	PB1=1'b1;switch_input[3:0]=4'b1001;
	#10
	PB2=1'b1;switch_input[3:0]=3'b1111;
	#10
	PB3=1'b1;switch_input[3:0]=4'b1110;
	#10
	PB4=1'b1;switch_input[3:0]=3'b0011;
end
      
endmodule

