`include"sub.v"
`timescale 1ps / 1ps 
module testbench;
	reg [63:0] a,b;
	wire [63:0] out;
	wire c;
	integer i,k;
	sub DUT(out,c,a,b);
	initial begin
	$monitor ($time,"ns: a = %b,\n\t\t        b = %b,\n\t\t       sum= %b, carry=%b \n",a, b, out,c); 
	$dumpfile("sub.vcd");
    	$dumpvars(0,a,b,c,out);
	b=2**6-1;
	a=2**5-1;
	#10;
	for(i=0; i<=2**4-1; i++) begin
		b=2**6-1;
		for(k=0;k<=2**4-1;k++) begin
		b--;
		#10;
		end
		a--;
	end
	end
endmodule