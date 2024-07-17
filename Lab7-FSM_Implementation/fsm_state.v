`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:06:33 03/11/2024 
// Design Name: 
// Module Name:    fsm_state 
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
module fsm_state(clk,Y,state);

input clk;
input [1:0] Y;
output state;
reg[3:0] state;
reg[2:0] microcoderom[0:12];
reg[3:0] dispatch3[0:3];
reg[3:0] dispatch10[0:3];
reg[31:0] count;
initial begin
  state=0;
  count=0;
  microcoderom[0]<=0;
  microcoderom[1]<=0;
  microcoderom[2]<=0;
  microcoderom[3]<=1;
  microcoderom[4]<=2;
  microcoderom[5]<=2;
  microcoderom[6]<=0;
  microcoderom[7]<=0;
  microcoderom[8]<=0;
  microcoderom[9]<=0;
  microcoderom[10]<=3;
  microcoderom[11]<=4;
  microcoderom[12]<=4;
  dispatch3[0]=3'b100;
  dispatch3[1]=3'b101;
  dispatch3[2]=3'b110;
  dispatch3[3]=3'b110;
  dispatch10[0]=11;
  dispatch10[1]=12;
  dispatch10[2]=12;
  dispatch10[3]=12;
end



always@(posedge clk) begin

    if(count==100000000) begin
        if(microcoderom[state]==0) begin
            state <= state+1;
        end
        else if(microcoderom[state]==1) begin
            state <= dispatch3[Y[1:0]];
        end
        else if(microcoderom[state]==2) begin
            state <= 7;
        end
        else if(microcoderom[state]==3) begin
            state <= dispatch10[Y[1:0]];
        end
        else if(microcoderom[state]==4) begin
            state <= 0;
        end
    count <= 0;
    end
    else begin
        count <= count+1;
    end     
end
endmodule
