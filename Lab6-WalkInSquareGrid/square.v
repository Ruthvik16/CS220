`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:43:43 03/04/2024 
// Design Name: 
// Module Name:    square 
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



module square(clk, rot_a, rot_b,Y,pos_x,pos_y);
     input clk, rot_a, rot_b;
	  input [3:0]Y;
	  wire rotation_event, rotation_direction;
	  output [3:0] pos_x;
	  output [3:0] pos_y;
	  wire [3:0] pos_x;
	  wire [3:0] pos_y;
	  
	  detect_event DE (clk, rot_a, rot_b, rotation_event, rotation_direction);
	  grid uut(clk,Y,rotation_event,pos_x,pos_y);

endmodule

module grid(clk,Y,rotation_event,pos_x,pos_y);
input [3:0] Y;
input clk,rotation_event;
output [3:0] pos_x;
output [3:0] pos_y;
reg [3:0] pos_x;
reg [3:0] pos_y;
reg [4:0] checkx;
reg[4:0] checky; 
wire[4:0] x;
wire[4:0] y; 
reg [2:0] direction;
reg dirx;
reg diry;
reg [4:0] distance;
wire [2:0] carry;
reg prevrot;
initial begin
pos_x=0;
pos_y=0;
x=0;
y=0;
prevrot=0;
direction=0;
distance=0;
end

always@(posedge clk) begin
if(prevrot==0 && rotation_event==1)begin
checkx<=pos_x;
checky<=pos_y;
direction<=Y[1:0];
distance[1:0]<=Y[3:2];
if(direction==0 || direction==1) begin
  if(direction==0 && carry[0]==1) begin
  pos_x<=15;
  end
  else if(direction==0 && carry[0]==0) begin
  pos_x<=x;
  end
  else if(direction==1 && carry[1]==1) begin
  pos_y<=15;
  end
  else if(direction==0 && carry[1]==0) begin
  pos_y<=y;
  end
end

else if(direction==2 || direction==3) begin
  if(direction==2 && carry[0]==1) begin
  pos_x<=0;
  end
  else if(direction==2 && carry[0]==0) begin
  pos_x<=x;
  end
  else if(direction==3 && carry[1]==1) begin
  pos_y<=0;
  end
  else if(direction==3 && carry[1]==0) begin
  pos_y<=y;
  end
end

end
prevrot<=rotation_event;
end

five_bit_adder uut1(checkx,distance,direction[1],x,carry[0]);
five_bit_adder uut2(checky,distance,direction[1],y,carry[1]);

endmodule

module full_adder(a, b, cin, sum, cout
    );

   input a;
   input b;
   input cin;

   output sum;
   wire sum;
   output cout;
   wire cout;
	
   assign sum = a^b^cin;
   assign cout = (a & b) | (b & cin) | (cin & a);

endmodule

module five_bit_adder(a, b, cin, sum, cout
    );

	input [4:0] a;
	input [4:0] b;
	input cin;
	
	output [4:0] sum;
	output cout;
	wire [4:0] sum;
	wire cout;
	
	wire carry;
	
	four_bit_adder FA4 (a[3:0], b[3:0], cin, sum[3:0], carry);
	full_adder FA5 (a[4], b[4]^cin, carry, sum[4], cout);

endmodule

module four_bit_adder(a, b, cin, sum, cout
    );

	input [3:0] a;
	input [3:0] b;
	input cin;
	
	output [3:0] sum;
	output cout;
	wire [3:0] sum;
	wire cout;
	
	wire [2:0] carry;
	
	full_adder FA0 (a[0], b[0]^cin, cin, sum[0], carry[0]);
	full_adder FA1 (a[1], b[1]^cin, carry[0], sum[1], carry[1]);
	full_adder FA2 (a[2], b[2]^cin, carry[1], sum[2], carry[2]);
	full_adder FA3 (a[3], b[3]^cin, carry[2], sum[3], cout);

endmodule


module detect_event(clk, rot_a, rot_b, rotation_event, rotation_direction
    );

	input clk, rot_a, rot_b;
	output rotation_event, rotation_direction;
	reg rotation_event, rotation_direction;
	
	always @ (posedge clk) begin
		if ((rot_a == 1) && (rot_b == 1)) begin
			rotation_event <= 1;
		end
		else if ((rot_a == 0) && (rot_b == 0)) begin
			rotation_event <= 0;
		end
		else if ((rot_a == 0) && (rot_b == 1)) begin
			rotation_direction <= 1;
		end
		else begin
			rotation_direction <= 0;
		end
	end

endmodule