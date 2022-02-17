`include"add.v"
module sub(sum,carry_overflow,A,B);
input signed [63:0] A,B;
output signed [63:0] sum;
output signed carry_overflow;
genvar i;
wire [63:0] Y;
generate for(i=0;i<64;i=i+1)
    not gate0(Y[i],B[i]);
endgenerate
add s1(sum, carry_overflow,A,Y,1'b1);

endmodule 
