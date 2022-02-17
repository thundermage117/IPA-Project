`include"add.v"
`timescale 1ps / 1ps 
module testbench;
	reg [63:0] a,b;
	reg cin;
	wire [63:0] out;
	wire c;
	integer i,k;
	add DUT(out,c,a,b,cin);
	initial begin
	//$monitor ($time,"ns: a = %b,\n\t\t        b = %b,\n\t\t       sum= %b, carry=%b \n",a, b, out,c); 
	$dumpfile("add.vcd");
    	$dumpvars(0,a,b,c,out);
	b=2**10-1;
	a=2**10-1;
	cin=0;
	#10;
	for(i=0; i<=2**4-1; i++) begin
		a=2**10-1;
		for(k=0;k<=2**4-1;k++) begin
		a--;
		#10;
		end
		b--;
	end
	end
endmodule