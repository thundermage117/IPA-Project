module Register(icode,cnd,rA,rB,valA,valB,valE,valM,clk);

input [3:0] icode;
input cnd;
input [3:0] rA;
input [3:0] rB;
input [63:0] valE;
input [63:0] valM;
input clk;
output reg [63:0] valA;
output reg [63:0] valB;
  

reg [0:63]reg_store[14:0];

initial 
    begin
		$readmemh("REG_MEM.txt", reg_store, 0, 14);
	end

reg [3:0] readA,readB,writeM,writeE;
//update after execute completion
always @(*)     //Decode
begin
    if(icode==4'h0)		//halt
	begin
		readA<=4'hF;
        readB<=4'hF;
	end
	else if(icode==4'h1)	//nop
	begin
		readA<=4'hF;
        readB<=4'hF;
	end
	else if(icode==4'h2)	//IRRMOVQ
	begin
		readA<=rA;
        readB<=4'hF;
	end
	else if(icode==4'h3)	//IIRMOVQ
	begin
		readA<=4'hF;
        readB<=4'hF;
	end
	else if(icode==4'h4)	//IRMMOVQ
	begin
		readA<=rA;
        readB<=rB;
	end	
	else if(icode==4'h5)	//IMRMOVQ
	begin
		readA<=4'hF;
        readB<=rB;
	end
	else if(icode==4'h6)	//IOPQ
	begin
		readA<=rA;
        readB<=rB;
	end
	else if(icode==4'h7)	//IJXX
	begin
		readA<=4'hF;
        readB<=4'hF;
	end
	else if(icode==4'h8)	//ICALL
	begin
		readA<=4'hF;
        readB<=4;
	end
	else if(icode==4'h9)	//IRET
	begin
		readA<=4;
        readB<=4;
	end
	else if(icode==4'hA)	//IPUSHQ
	begin
		readA<=rA;
        readB<=4;
	end
	else if(icode==4'hB)	//IPOPQ
	begin
		readA<=4;
        readB<=4;
	end
    if(readA!=4'hF)
        valA<=reg_store[readA];
    if(readB!=4'hF)
        valB<=reg_store[readB];
end

always @(negedge clk)     //Write-Back
begin
    if(icode==4'h0)		//halt
	begin
		writeM<=4'hF;
        writeE<=4'hF;
	end
	else if(icode==4'h1)	//nop
	begin
		writeM<=4'hF;
        writeE<=4'hF;
	end
	else if(icode==4'h2)	//IRRMOVQ
	begin
		writeM<=4'hF;
        writeE<=rB;
	end
	else if(icode==4'h3)	//IIRMOVQ
	begin
		writeM<=4'hF;
        writeE<=rB;
	end
	else if(icode==4'h4)	//IRMMOVQ
	begin
		writeM<=4'hF;
        writeE<=4'hF;
	end	
	else if(icode==4'h5)	//IMRMOVQ
	begin
		writeM<=rA;
        writeE<=4'hF;
	end
	else if(icode==4'h6)	//IOPQ
	begin
		writeM<=4'hF;
        writeE<=rB;
	end
	else if(icode==4'h7)	//IJXX
	begin
		writeM<=4'hF;
        writeE<=4'hF;
	end
	else if(icode==4'h8)	//ICALL
	begin
		writeM<=4'hF;
        writeE<=4;
	end
	else if(icode==4'h9)	//IRET
	begin
		writeM<=4'hF;
        writeE<=4;
	end
	else if(icode==4'hA)	//IPUSHQ
	begin
		writeM<=4'hF;
        writeE<=4;
	end
	else if(icode==4'hB)	//IPOPQ
	begin
		writeM<=rA;
        writeE<=4;
	end

    if(writeM!=4'hF)
    begin
        reg_store[writeM]<=valM;
        $writememh("REG_MEM.txt", reg_store, 0,14);
    end
    if(writeE!=4'hF)
    begin
        reg_store[writeE]<=valE;
        $writememh("REG_MEM.txt", reg_store, 0,14);
    end
end
endmodule