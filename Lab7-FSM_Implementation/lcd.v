`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:38:14 03/11/2024 
// Design Name: 
// Module Name:    lcd 
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




module LCD_MIN(clk, Y, lcd_rs, lcd_rw, lcd_e, PB1, PB2, PB3, PB4,lcd4,lcd5,lcd6,lcd7
    );
input[2:0] Y;
input clk, PB1, PB2, PB3, PB4;
output lcd_rs, lcd_rw, lcd_e,lcd4,lcd5,lcd6,lcd7;
wire lcd_rs, lcd_rw, lcd_e, lcd4,lcd5,lcd6,lcd7;
wire[7:0] DB;
wire[1:0] minpos;

reg[127:0] line1, line2;
reg[2:0] A, B, C, D;
reg[1:0] count;
reg flag =0;
initial begin
    count <= 2'b00;
    A <= 3'b0;
    B <= 3'b0;
    C <= 3'b0;
    D <= 3'b0;
    flag <= 0;
end

always@(posedge PB1) begin
            A = Y[2:0];
            line1[127:120] <= 8'b00110000;
            line1[122:120] <= A;
            line1[119:112] <= 8'b00101100;
            line1[111:104] <= 8'b00100000;
end
always@(posedge PB2) begin
            B = Y[2:0];
            line1[103:96] <= 8'b00110000;
            line1[98:96] <= B;
            line1[95:88] <= 8'b00101100;
            line1[87:80] <= 8'b00100000;
end
always@(posedge PB3) begin
            C = Y[2:0];
            line1[79:72] <= 8'b00110000;
            line1[74:72] <= C;
            line1[71:64] <= 8'b00101100;
            line1[63:56] <= 8'b00100000;
end
always@(posedge PB4) begin
            D = Y[2:0];
            line1[55:48] <= 8'b00110000;
            line1[50:48] <= D;
            line1[47:40] <= 8'b00100000;
            line1[39:32] <= 8'b00100000;
            line1[31:24] <= 8'b00100000;
            line1[23:16] <= 8'b00100000;
            line1[15:8] <= 8'b00100000;
            line1[7:0] <= 8'b00100000;

            line2[127:120] <= DB;
            line2[119:112] <= 8'b00100000;
            line2[111:104] <= 8'b00100000;
            line2[103:96] <= 8'b00100000;
            line2[95:88] <= 8'b00100000;
            line2[87:80] <= 8'b00100000;
            line2[79:72] <= 8'b00100000;

            line2[71:64] <= 8'b00100000;
            line2[63:56] <= 8'b00100000;
            line2[55:48] <= 8'b00100000;
            line2[47:40] <= 8'b00100000;
            line2[39:32] <= 8'b00100000;
            line2[31:24] <= 8'b00100000;
            line2[23:16] <= 8'b00100000;
            line2[15:8] <= 8'b00100000;
            line2[7:0] <= 8'b00100000;
            flag <= 1;

end

findmin uut0(A, B, C, D, clk, DB, minpos);

lcd uut1(line1,line2,clk, lcd_rs, lcd_rw, lcd_e, lcd4,lcd5,lcd6,lcd7,flag);

endmodule

module findmin( A, B, C, D, clk, DB, minpos);

input [2:0] A, B, C, D;
input clk;
output DB;
reg[7:0] DB;
output minpos;
reg[1:0] minpos;

initial begin
    DB <= 8'b0;
    minpos <= 2'b00;
end

always @(posedge clk) begin
    if ((A <= B) && (A <= C) && (A <= D)) begin
        DB = 8'b00110000;
        minpos = 2'b00;
    end
    else if ((B <= A) && (B <= C) && (B <= D)) begin
        DB = 8'b00110001;
        minpos = 2'b01;
    end
    else if ((C <= A) && (C <= B) && (C <= D)) begin
        DB = 8'b00110010;
        minpos = 2'b10;
    end
    else if ((D <= A) && (D <= B) && (D <= C)) begin
        DB = 8'b00110011;
        minpos = 2'b11;
    end
end
endmodule

module lcd(
	first_line,
	second_line,
	clk,
	lcd_rs,
	lcd_rw,
	lcd_e,
	lcd4,
	lcd5,
	lcd6,
	lcd7,
	flag
    );

	input [0:127] first_line;
	input [0:127] second_line;
	input clk;
	input flag;
	output lcd_rs, lcd_rw, lcd_e, lcd4, lcd5, lcd6, lcd7;
	reg lcd_rs, lcd_rw, lcd_e, lcd4, lcd5, lcd6, lcd7;

	reg [7:0] first_line_index = 0;
	reg [1:0] first_line_state = 3;
	 
	reg [7:0] second_line_index = 0;
	reg [1:0] second_line_state = 3;
	 
	reg [19:0] counter = 1_000_000;
	reg [2:0] next_state = 0;
	 
	reg [2:0] line_break_state = 7;
	 
	reg [5:0] init_ROM [0:13];
	reg [3:0] init_ROM_index = 0;
	 
	// Initialization code
	initial begin
		init_ROM[0] = 6'h03;
		init_ROM[1] = 6'h03;
		init_ROM[2] = 6'h03;
		init_ROM[3] = 6'h02;
		init_ROM[4] = 6'h02;
		init_ROM[5] = 6'h08;
		init_ROM[6] = 6'h00;
		init_ROM[7] = 6'h06;
		init_ROM[8] = 6'h00;
		init_ROM[9] = 6'h0c;
		init_ROM[10] = 6'h00;
		init_ROM[11] = 6'h01;
		init_ROM[12] = 6'h08;
		init_ROM[13] = 6'h00;
	end
	
	always @ (posedge clk) begin
	
	   	if (counter == 0 && flag==1) begin
		   	counter <= 1_000_000;
			
			// Initialization state machine
			if (init_ROM_index == 14) begin
				next_state <= 4;
				init_ROM_index <= 0;
				first_line_state <= 0;
			end
					
			if ((next_state != 4) && (init_ROM_index != 14)) begin
			  	case (next_state)
			    		0: begin
						lcd_e <= 0;
						next_state <= 1;
               		    		end
					
                            		1: begin
						{lcd_rs, lcd_rw, lcd7, lcd6, lcd5, lcd4} <= init_ROM[init_ROM_index];
						next_state <= 2;
			    		end
					
			    		2: begin
						lcd_e <= 1;
						next_state <= 3;
			    		end
					
			    		3: begin
						lcd_e <= 0;
						next_state <= 1;
						init_ROM_index <= init_ROM_index + 1;
			    		end
			  	endcase
			end
			
			// First line state machine
			if (first_line_index == 128) begin
				first_line_state <= 3;
				first_line_index <= 0;
				line_break_state <= 0;
			end
			if ((first_line_state != 3) && (first_line_index != 128)) begin
				case (first_line_state)
					0: begin
						{lcd_rs, lcd_rw, lcd7, lcd6, lcd5, lcd4} <= {2'h2,first_line[first_line_index],first_line[first_line_index+1],first_line[first_line_index+2],first_line[first_line_index+3]};
						first_line_state <= 1;
					end
						
					1: begin
						lcd_e <= 1;
						first_line_state <= 2;
					end
					
					2: begin
						lcd_e <= 0;
						first_line_state <= 0;
						first_line_index <= first_line_index+4;
					end
				endcase
			end
			
			// Line break state machine
			if (line_break_state != 7) begin
				case (line_break_state)
					0: begin
						{lcd_rs, lcd_rw, lcd7, lcd6, lcd5, lcd4} <= 6'h0c;
						line_break_state <= 1;
					end
						
					1: begin
						lcd_e <= 1;
						line_break_state <= 2;
					end
						
					2: begin
						lcd_e <= 0;
						line_break_state <= 3;
					end
						
					3: begin
						{lcd_rs, lcd_rw, lcd7, lcd6, lcd5, lcd4} <= 6'h00;
						line_break_state <= 4;
					end
						
					4: begin
						lcd_e <= 1;
						line_break_state <= 5;
					end
						
					5: begin
						lcd_e <= 0;
						line_break_state <= 7;
						second_line_state <= 0;
					end
				endcase
			end
			
			// Second line state machine
			if (second_line_index == 128) begin
				second_line_state <= 3;
				second_line_index <= 0;
			end
			if ((second_line_state != 3) && (second_line_index != 128)) begin
				case (second_line_state)
					0: begin
						{lcd_rs, lcd_rw, lcd7, lcd6, lcd5, lcd4} <= {2'h2,second_line[second_line_index],second_line[second_line_index+1],second_line[second_line_index+2],second_line[second_line_index+3]};
						second_line_state <= 1;
					end
						
					1: begin
						lcd_e <= 1;
						second_line_state <= 2;
					end
					
					2: begin
						lcd_e <= 0;
						second_line_state <= 0;
						second_line_index <= second_line_index+4;
					end
				endcase
			end
		end
		else 
		begin 
		   	counter <= counter - 1;
		end
	end
	
endmodule
