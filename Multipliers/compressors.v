///////////////////////////////////////////////////////////////////////////////////////////////////
// Owned by : Prashanth H C, Prashanth.C@iiitb.ac.in / prashanth.c@iiitb.org
// File distributed under MIT License.
// 2021 September
//
// Complete implementation : https://github.com/PrashanthHC16/Approximate-Multipliers
//
// Part of paper "Performance and Error Analysis of Approximate Multipliers of Different Configurations and Fast Adders"
// Authors : Prashanth H C, Soujanya S R, Bindu G Gowda, Madhav Rao
//
///////////////////////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps


/////////////////////////////////////////////// exact compressors /////////////////////////////////

//module exact_compressors3_2(input [2:0]p, output [2:1]w   );
//   xor sum(w[1], p[2],p[1],p[0]);
//   wire ab,bc,ca;
//   and a1(ab,p[2],p[1]);
//   and a2(bc,p[1],p[0]);
//   and a3(ca,p[0],p[2]);
//   or carry(w[2], ab,bc,ca);
//endmodule

//module exact_compressor2_2(input [1:0]p, output [2:1]w);
//    xor sum(w[1],p[0],p[1]);
//    and carry(w[2],p[0],p[1]);
//endmodule

module FA(input [2:0]p, output [2:1]w   );  // w[2] = carry ;  w[1] =sum
   xor sum(w[1], p[2],p[1],p[0]);
   wire ab,bc,ca;
   and a1(ab,p[2],p[1]);
   and a2(bc,p[1],p[0]);
   and a3(ca,p[0],p[2]);
   or carry(w[2], ab,bc,ca);
endmodule

module HA(input [1:0]p, output [2:1]w);
    xor sum(w[1],p[0],p[1]);
    and carry(w[2],p[0],p[1]);
endmodule

module full_adder(input a,input b, input c_in ,output sum,output carry); //dadda8
assign sum = a ^ b ^ c_in;
assign carry = (a & b) +(b & c_in) + (a & c_in);
endmodule // full_adder

module half_adder(input a, input b,output  sum, output  carry); //dadda8
assign sum = a ^ b;
assign carry = a & b;
endmodule // half_adder
    
 module fa(input A, B, Ci, output S, Co   ); //dadda16
     xor xor1(S, A, B, Ci);
     assign Co = (A & B) | (B & Ci) | (Ci & A);
endmodule

module ha(input A,B,output S,C    ); //dadda16
    xor x1(S,A,B);
    and x2(C,A,B);
endmodule


////////////////////////////////// approximate compressors //////////////////////////////////////

//module compressor2_1(input [1:0]p, output w1);     //   0,p1, output w1);    
//    or u1(w1 , p[0] , p[1]);  //assign w1 = p0 | p1;  
//endmodule

module compressor3_2(input [2:0]p, output [2:1]w); //  p2,p1,p0, output w1,w2);
    wire a1;
    and u1(a1 , p[0] , p[1]); //assign a1 = p0 & p1;
    or  u2(w[2] , a1 , p[2]);  //assign w2 = a1 | p2;
    or  u3(w[1] , p[0] , p[1]);  //assign w1 = p0 |p1;
endmodule

module compressor4_2(input [3:0]p, output [2:1]w);  // p3,p2,p1,p0, output w2,w1);
    wire a1,a2;
    and u1(a1 , p[0] , p[1]);     //assign a1 = p0 & p1;
    and u2(a2 , p[2] , p[3]);     //assign a2 = p2 & p3;
    or u3(w[2] , a1 , p[2] , p[3]); //assign w2 = a1 | p2 | p3;
    or u4(w[1] , a2 , p[0] , p[1]); //assign w1 = a2 | p0 | p1;
endmodule

module compressor5_3(input [4:0]p, output [3:1]w); //  p4,p3,p2,p1,p0, output w3,w2,w1);
    wire a1,a2;
    and u1(a1 , p[0] , p[1]);      //assign a1 = p0 & p1;
    and u2(a2 , p[2] , p[3]);      //assign a2 = p2 & p3;
    or u3(w[3] , p[0] , p[1]);       //assign w3 = p0 | p1;
    or u4(w[1] , a1 , p[2] , p[3]);  //assign w1 = a1 | p2 | p3;
    or u5(w[2] , a2 , p[4]);       //assign w2 = a2 | p4;
endmodule

module compressor6_3(input [5:0]p, output [3:1]w); //  p5,p4,p3,p2,p1,p0, output w3,w2,w1);
    wire a1,a2,a3;
    and u1(a1 , p[0] , p[1]);      //assign a1 = p0 & p1;
    and u2(a2 , p[2] , p[3]);      //assign a2 = p2 & p3;
    and u3(a3 , p[4] , p[5]);      //assign a3 = p4 & p5;
    or u4(w[1] , a1 , p[2] , p[3]);  //assign w1 = a1 | p2 | p3;
    or u5(w[3] , a2 , p[4] , p[5]);  //assign w3 = a2 | p4 | p5;
    or u6(w[2] , a3 , p[0] , p[1]);  //assign w2 = a3 | p0 | p1;
endmodule


//////////////////////////////////////// higher order compressors //////////////////////

module compressor7_4(input [6:0]p, output [4:1]w);
    compressor4_2 u1(.p(p[6:3]), .w(w[4:3]));
    compressor3_2 u2(.p(p[2:0]), .w(w[2:1]));
endmodule

module compressor8_4(input [7:0]p, output [4:1]w);
    compressor4_2 u1(.p(p[7:4]), .w(w[4:3]));
    compressor4_2 u2(.p(p[3:0]), .w(w[2:1]));
endmodule

module compressor9_5(input [8:0]p, output [5:1]w);
   // compressor5_3 u1(.p(p[8:4]), .w(w[5:3]));
    compressor4_2 u2(.p(p[8:5]), .w(w[5:4]));
    compressor5_3 u1(.p(p[4:0]), .w(w[3:1]));
endmodule

module compressor10_5(input [9:0]p, output [5:1]w);
  //  compressor6_3 u1(.p(p[9:4]), .w(w[5:3]));
    compressor4_2 u2(.p(p[9:6]), .w(w[5:4]));
    compressor6_3 u1(.p(p[5:0]), .w(w[3:1]));
endmodule

module compressor11_6(input [10:0]p, output [6:1]w);
    compressor4_2 u1(.p(p[10:7]), .w(w[6:5]));
    compressor4_2 u2(.p(p[6:3]), .w(w[4:3]));
    compressor3_2 u3(.p(p[2:0]), .w(w[2:1]));
endmodule

module compressor12_6(input [11:0]p, output [6:1]w);
    compressor4_2 u1(.p(p[11:8]), .w(w[6:5]));
    compressor4_2 u2(.p(p[7:4]), .w(w[4:3]));
    compressor4_2 u3(.p(p[3:0]), .w(w[2:1]));
endmodule

module compressor13_7(input [12:0]p, output [7:1]w);
  //  compressor5_3 u1(.p(p[12:8]), .w(w[7:5]));
    compressor4_2 u2(.p(p[12:9]), .w(w[7:6]));
    compressor4_2 u3(.p(p[8:5]), .w(w[5:4]));
    compressor5_3 u1(.p(p[4:0]), .w(w[3:1]));
endmodule

module compressor14_7(input [13:0]p, output [7:1]w);
 //   compressor6_3 u1(.p(p[13:8]), .w(w[7:5]));
    compressor4_2 u2(.p(p[13:10]), .w(w[7:6]));
    compressor4_2 u3(.p(p[9:6]), .w(w[5:4]));
    compressor6_3 u1(.p(p[5:0]), .w(w[3:1]));
endmodule

module compressor15_8(input [14:0]p, output [8:1]w);
    compressor4_2 u1(.p(p[14:11]), .w(w[8:7]));
    compressor4_2 u2(.p(p[10:7]), .w(w[6:5]));
    compressor4_2 u3(.p(p[6:3]), .w(w[4:3]));
    compressor3_2 u4(.p(p[2:0]), .w(w[2:1]));
endmodule

module compressor16_8(input [15:0]p, output [8:1]w);
    compressor4_2 u1(.p(p[15:12]), .w(w[8:7]));
    compressor4_2 u2(.p(p[11:8]), .w(w[6:5]));
    compressor4_2 u3(.p(p[7:4]), .w(w[4:3]));
    compressor4_2 u4(.p(p[3:0]), .w(w[2:1]));
endmodule

//module compressor17_9(input [16:0]p, output [9:1]w);
//    compressor5_3 u1(.p(p[16:12]), .w(w[9:7]));
//    compressor4_2 u2(.p(p[11:8]), .w(w[6:5]));
//    compressor4_2 u3(.p(p[7:4]), .w(w[4:3]));
//    compressor4_2 u4(.p(p[3:0]), .w(w[2:1]));
//endmodule

//module compressor18_9(input [17:0]p, output [9:1]w);
//    compressor6_3 u1(.p(p[17:12]), .w(w[9:7]));
//    compressor4_2 u2(.p(p[11:8]), .w(w[6:5]));
//    compressor4_2 u3(.p(p[7:4]), .w(w[4:3]));
//    compressor4_2 u4(.p(p[3:0]), .w(w[2:1]));
//endmodule

//module compressor19_10(input [18:0]p, output [10:1]w);
//    compressor4_2 u1(.p(p[18:15]), .w(w[10:9]));
//    compressor4_2 u2(.p(p[14:11]), .w(w[8:7]));
//    compressor4_2 u3(.p(p[10:7]), .w(w[6:5]));
//    compressor4_2 u4(.p(p[6:3]), .w(w[4:3]));
//    compressor3_2 u5(.p(p[2:0]), .w(w[2:1]));
//endmodule

//module compressor20_10(input [19:0]p, output [10:1]w);
//    compressor4_2 u1(.p(p[19:16]), .w(w[10:9]));
//    compressor4_2 u2(.p(p[15:12]), .w(w[8:7]));
//    compressor4_2 u3(.p(p[11:8]), .w(w[6:5]));
//    compressor4_2 u4(.p(p[7:4]), .w(w[4:3]));
//    compressor4_2 u5(.p(p[3:0]), .w(w[2:1]));
//endmodule