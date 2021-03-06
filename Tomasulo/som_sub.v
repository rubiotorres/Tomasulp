module Count(clk,RUN,reset,q);
	input clk,RUN,reset;
	output reg [2:0]q;
	initial
		q = 0;
	always@(posedge clk) begin
		if(q == 3 || reset)
			q = 0;
		else if(RUN)	
			q = q + 1;
	end
endmodule

module FU_add_sub(clk,RUN,RegX,RegY,OpCode,Result,Done,InputX_AddSub,InputLabel_AddSub,AddressX,Label);
	input [8:0]RegX,RegY;
	input [2:0]OpCode,InputX_AddSub,InputLabel_AddSub;
	input clk,RUN;
	output reg Done;
	output [2:0]AddressX,Label;
	output reg [8:0]Result;
	wire [2:0]count;
	
	assign AddressX = InputX_AddSub;
	assign Label = InputLabel_AddSub;
	
	always@(clk,RegX,RegY,OpCode,RUN) begin
		Done = 0;
		if(count == 2 && OpCode == 3'b000) begin
			Result = RegX + RegY; //ADD
			Done = 1;
		end
		else if(count == 2 && OpCode == 3'b001) begin
			Result = RegX - RegY; //SUB 
			Done = 1;
		end
	end
	Count c(clk,RUN,Done,count);
endmodule