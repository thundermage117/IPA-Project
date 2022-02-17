`include "xor64.v"
`include "and64.v"
`include "sub.v"
module alu (control,A,B,out,carry_overflow);
input [1:0] control;
input signed [63:0] A,B;
output reg[63:0] out ;
reg [1:0] x;
output reg carry_overflow;
wire [63:0] sum_out,and_out,xor_out,sub_out;
wire carry_sum,carry_sub;
   add module1(sum_out,carry_sum,A,B,1'b0);
   and64 module2(and_out,A,B);
   xor64 module3(xor_out,A,B);
   sub module4(sub_out,carry_sub,A,B);

   always@(*)
   begin
	assign x=control;
       if(x==2'b00)
	begin
       	     assign out=sum_out;
	     assign carry_overflow=carry_sum;
	end
	
       else if(x==2'b01)
       begin
            assign out=sub_out;
            assign carry_overflow=carry_sub;
       end
       else if(x==2'b10)
       begin
           assign out=and_out;
           assign carry_overflow=1'b0;
       end
       else if(x==2'b11)
        begin
            assign out=xor_out;
            assign carry_overflow=1'b0;
	end
   end

    
endmodule