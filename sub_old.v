module sub(sum,carry_overflow,A,B);
input signed [63:0] A,B;
output signed [63:0] sum;
output signed carry_overflow;
wire signed [65:0] carry;
wire signed [64:0] t1,t2,t3,X,Y,Z,t4;
genvar i;
assign carry[0]=1'b1; 
assign X={A[63],A};
assign t4={B[63],B};

generate for(i=0;i<=64;i=i+1)
begin
    not gate0(Y[i],t4[i]);
    xor gate1(Z[i],X[i],Y[i],carry[i]);
    and gate2(t1[i],X[i],Y[i]);
    and gate3(t2[i],Y[i],carry[i]);
    and gate4(t3[i],X[i],carry[i]);
    or gate5(carry[i+1],t1[i],t2[i],t3[i]);
end
endgenerate
assign carry_overflow=Z[64];
generate for(i=0;i<64;i=i+1)
begin
    assign sum[i]=Z[i];
end
endgenerate
endmodule

/* Subtraction using sign-extension, output will be exact 65 bits. eg: 3-bit 010-100
 2=010=0010
-4=100=1100

       0010
      +0011(2's complement)
      =0110 = 6

*/
