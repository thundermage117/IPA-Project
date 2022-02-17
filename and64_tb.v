`include"and64.v"
`timescale 10ns / 10ns 
module testbench;
	reg [63:0] a,b;
	wire [63:0] out;
	integer i,k;
	and64 DUT(out,a,b);
	initial begin
	$monitor ($time,"ns: a = %b,\n\t\t        b = %b,\n\t\t       and= %b\n",a, b, out); 
	$dumpfile("and64.vcd");
    	$dumpvars(0,a,b,out);
	b=2**32-1;
	a=2**32-1;
	#1;
	for(i=0; i<=2**4-1; i++) begin
		a=2**32-1;
		for(k=0;k<=2**4-1;k++) begin
		a--;#1;
		end
		b=b-100;
	end
	end
endmodule