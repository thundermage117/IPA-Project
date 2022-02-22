`include "fetch.v"
`include "Register.v"
`include "execute.v"
`include "Memory.v"
`include "pc_update.v"

module seq();

reg [63:0]PC_in=0;
wire [63:0]PC;
wire [3:0] icode;
wire [3:0] ifun;
wire [3:0] rA;
wire [3:0] rB;
wire [63:0]valC;
wire [63:0]valP;
wire [63:0]valA;
wire [63:0]valB;
wire [63:0]valM;
wire [63:0]valE;

wire instr_valid;
wire Cnd;

reg clk;

fetch FETCH(.PC(PC_in),.icode(icode),.ifun(ifun),.rA(rA),.rB(rB),.valC(valC),.valP(valP),.clk(clk),.instr_valid(instr_valid));
Register REGISTER(.icode(icode),.Cnd(Cnd),.rA(rA),.rB(rB),.valA(valA),.valB(valB),.valE(valE),.valM(valM),.clk(clk));
execute EXECUTE(.icode(icode),.ifun(ifun),.valC(valC),.valA(valA),.valB(valB),.valE(valE),.Cnd(Cnd),.clk(clk));
Memory MEMORY(.icode(icode),.valE(valE),.valA(valA),.valP(valP),.instr_valid(instr_valid),.valM(valM),.clk(clk));
pc_update PC_UPDATE(.PC(PC),.icode(icode),.Cnd(Cnd),.valC(valC),.valM(valM),.valP(valP),.clk(clk));

integer j;

initial begin
	//$monitor ($time,"ns:  clk=%b, PC=%h, icode=%h, ifun=%h, valP=%h\n",clk,PC,icode,ifun,valP); 
	$dumpfile("Seq.vcd");
    	$dumpvars(0,PC,icode,ifun,rA,rB,valC,valP,valA,valB,valM,valE,instr_valid,Cnd,clk,PC_in);
	clk=0;
	//valE='h2A382812;
	//#10;
	for(j=0;j<600;j++) begin 
	//valE=j+'h3424867AEC; //non-blocking=> o/p next cycle
	clk=1;
	#10;
	clk=0;
	#10;
	end
end

always @(posedge clk)
    PC_in<=PC;
endmodule