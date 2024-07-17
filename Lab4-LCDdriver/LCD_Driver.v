`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:38:21 02/12/2024 
// Design Name: 
// Module Name:    LCD_Driver 
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


module LCD(clk,led_e,led_rs,led_w,data);

input clk;

output wire led_e,led_rs,led_w;
output wire [3:0]data;
wire [127:0]line1,line2;


LCD_Driver L0(clk,"WELCOME TO CSE, ","IIT KANPUR      ", led_e, led_w, led_rs, data);


//assign line1=128'h57454C434F4D4520544F204353453333;
//assign line1=128'h75757057205720572057205720572057;
//assign line2=128'h20492049204920204B414E5055522020;


endmodule




module LCD_Driver( clk, line1, line2, led_e, led_w, led_rs, data);

input clk;
input [127:0]line1,line2;
output wire led_e, led_w, led_rs;
output wire [3:0] data;

reg [22:0] counter;
reg [2:0] inc;

reg led_er, led_wr, led_rsr;
reg [3:0] data_r;
reg [1:0] flag;
reg [7:0] index1,index2,index3,index4;

initial 
begin
led_er=0; led_wr=0; led_rsr =0;flag=0; index1 = 55; counter=0; inc=0;index2=127;index3=7;index4=127;
end

wire[55:0] config_data;
wire[7:0] br;
assign config_data=56'h333228060C0180;
assign br = 8'hC0;

always @(posedge clk)
begin
	counter = counter + 1;
	if(counter == 1000000 && inc==3'b000)
	begin
		if(flag==2'b00)
		begin
			led_er=0;
			flag = flag+1;
		end
		else if(flag == 2'b01)
		begin
			data_r[3] = config_data[index1];
			data_r[2] = config_data[index1-1];
			data_r[1] = config_data[index1-2];
			data_r[0] = config_data[index1-3];
			flag=flag+1;	
		end
		else if(flag == 2'b10)
		begin
			
			if (index1 == 3)
			begin
				inc = 3'b001;
				flag=0;
			end
			led_er=1;
			flag = 0;
			index1 = index1-4;
		end
		counter = 0;
	end
	else if(inc == 3'b001 && counter == 1000000)
	begin
		
		if(flag==2'b00)
		begin
			led_er=0;
			flag = flag+1;
		end
		else if(flag == 2'b01)
		begin
			led_rsr =1;
			led_wr =0;
			data_r[3] = line1[index2];
			data_r[2] = line1[index2-1];
			data_r[1] = line1[index2-2];
			data_r[0] = line1[index2-3];
			flag=flag+1;
			
		end
		else if(flag == 2'b10)
		begin
			if (index2 ==3)
			begin
				inc = 3'b010;
				flag=0;
			end
			led_er=1;
			flag = 0;
			index2 = index2-4;
		end
		counter = 0;
	end
	else if(inc == 3'b010 && counter == 1000000)
	begin
		
		if(flag == 2'b00)
		begin
			led_er=0;
			flag = flag+1;
		end
		else if(flag == 2'b01)
		begin
			led_rsr=0;
			led_wr=0;
			data_r[3] = br[index3];
			data_r[2] = br[index3-1];
			data_r[1] = br[index3-2];
			data_r[0] = br[index3-3];
			flag=flag+1;
		end
		else if(flag == 2'b10)
		begin
			if (index3 ==3)
			begin
				inc = 3'b011;
				flag=0;
			end
			led_er=1;
			flag = 0;
			index3 = index3-4;
		end
		counter = 0;
	end
	else if(inc == 3'b011 && counter == 1000000)
	begin
		if(flag==2'b00)
		begin
			led_er=0;
			flag = flag+1;
		end
		else if(flag == 2'b01)
		begin
			led_rsr=1;
			led_wr=0;
			data_r[3] = line2[index4];
			data_r[2] = line2[index4-1];
			data_r[1] = line2[index4-2];
			data_r[0] = line2[index4-3];
			flag=flag+1;	
		end
		else if(flag == 2'b10)
		begin
			if (index4 ==3)
			begin
				inc = 3'b110;
			end
			led_er=1;
			flag = 0;
			index4 = index4-4;
		end
		counter = 0;
	end	
end


assign data[3:0] = data_r[3:0];
assign led_e = led_er;
assign led_w = led_wr;
assign led_rs = led_rsr; 

endmodule 