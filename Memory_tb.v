`include"Memory.v"
`timescale 1ns / 1ns 
module testbench;
reg [3:0] icode;
reg [63:0] valE;
reg [63:0] valP;
reg clk;
reg instr_valid;
reg [63:0] valA;
wire [63:0] valM;

//check testbench for read part too
	integer i,k,j;
	Memory DUT(icode,valE,valA,valP,instr_valid,valM,clk);
	initial begin
	//$monitor ($time,"ns:  clk=%b, PC=%h, icode=%h, ifun=%h, valP=%h\n",clk,PC,icode,ifun,valP); 
	$dumpfile("Register.vcd");
    	$dumpvars(0,icode,valE,valA,valP,instr_valid,valM,clk);
	clk=0;
	icode=4'h4;
	valE='h6;
	//valA='h27359;
	//#10;
	for(j=0;j<4;j++) begin 
	valE=j+'h10; //non-blocking=> o/p next cycle
	valA=j+1;
	clk=1;
	#10;
	clk=0;
	#10;
	end
	//clk=1;
	//#10;
end
endmodule
/*
#10;
	clk=1;
	#10;
	PC=valP;
	clk=0;
	#10;	
	clk=1;
	#10;

*/