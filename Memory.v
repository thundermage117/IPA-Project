
module Memory(icode,valE,valA,valP,instr_valid,valM,clk); //add imem_error	

input [3:0] icode;
input [63:0] valE;
input [63:0] valA;
input [63:0] valP;
input instr_valid;
input clk;
output reg [63:0] valM;

reg [63:0] mem_addr,mem_data;
reg mem_read=1'b0;
reg mem_write=1'b0; //control signals
reg [0:63]data_memory[127:0];

initial 
    begin
		$readmemh("DATA_MEM.txt", data_memory, 0, 127);
	end

//update for instr-valid

always @(*)     
begin
	if(icode==4'h4)	//IRMMOVQ
	begin
		mem_write<=1'b1;
		mem_addr<=valE;
		mem_data<=valA;
	end	
	else if(icode==4'h5)	//IMRMOVQ
	begin
		mem_read<=1'b1;
		mem_addr<=valE;
	end
	else if(icode==4'h8)	//ICALL
	begin
		mem_write<=1'b1;
		mem_addr<=valE;
		mem_data<=valP;
	end
	else if(icode==4'h9)	//IRET
	begin
		mem_read<=1'b1;
		mem_addr<=valA;
	end
	else if(icode==4'hA)	//IPUSHQ
	begin
		mem_write<=1'b1;
		mem_addr<=valE;
		mem_data<=valA;
	end
	else if(icode==4'hB)	//IPOPQ
	begin
		mem_read<=1'b1;
		mem_addr<=valA;
	end
    if(mem_read==1'b1)
        valM<=data_memory[mem_read];
end

always @(clk)//ensures write takes place after the next clk cycle
begin
    if(mem_write==1'b1)
    begin
        data_memory[mem_addr]<=mem_data;
        $writememh("DATA_MEM.txt", data_memory, 0,127);
    end
end

endmodule 
