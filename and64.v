module and64(out,A,B);
input [63:0] A,B;
output [63:0] out;


genvar i;

generate for (i = 0; i <64;i=i+1)
 begin
   and g1(out[i],A[i],B[i]);
 end
endgenerate

endmodule