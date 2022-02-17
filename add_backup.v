`include"cla_4bits.v"
module add(sum,carry_overflow,A,B,cin);
input signed [63:0] A,B;
input cin;
output signed [63:0] sum;
output signed carry_overflow;
wire [18:0] carry;
wire [2:0] t1,t2,t3;
genvar i;
CLA_FULL c1(sum[3:0],carry[0],A[3:0],B[3:0],cin);
CLA_FULL c2(sum[7:4],carry[1],A[7:4],B[7:4],carry[0]);
CLA_FULL c3(sum[11:8],carry[2],A[11:8],B[11:8],carry[1]);
CLA_FULL c4(sum[15:12],carry[3],A[15:12],B[15:12],carry[2]);
CLA_FULL c5(sum[19:16],carry[4],A[19:16],B[19:16],carry[3]);
CLA_FULL c6(sum[23:20],carry[5],A[23:20],B[23:20],carry[4]);
CLA_FULL c7(sum[27:24],carry[6],A[27:24],B[27:24],carry[5]);
CLA_FULL c8(sum[31:28],carry[7],A[31:28],B[31:28],carry[6]);
CLA_FULL c9(sum[35:32],carry[8],A[35:32],B[35:32],carry[7]);
CLA_FULL c10(sum[39:36],carry[9],A[39:36],B[39:36],carry[8]);
CLA_FULL c11(sum[43:40],carry[10],A[43:40],B[43:40],carry[9]);
CLA_FULL c12(sum[47:44],carry[11],A[47:44],B[47:44],carry[10]);
CLA_FULL c13(sum[51:48],carry[12],A[51:48],B[51:48],carry[11]);
CLA_FULL c14(sum[55:52],carry[13],A[55:52],B[55:52],carry[12]);
CLA_FULL c15(sum[59:56],carry[14],A[59:56],B[59:56],carry[13]);
CLA_FULL c16(sum[63:60],carry[18],A[63:60],B[63:60],carry[14]);
generate for(i=0;i<3;i=i+1)
begin
    and gate2(t1[i],A[i+60],B[i+60]);
    and gate3(t2[i],B[i+60],carry[i+14]);
    and gate4(t3[i],A[i+60],carry[i+14]);
    or gate5(carry[i+1+14],t1[i],t2[i],t3[i]);
end
endgenerate
       xor(carry_overflow,carry[17],carry[18]);
endmodule 