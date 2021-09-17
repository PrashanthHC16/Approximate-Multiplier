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

/////////////////////////////////////////////////////////8 bit multipliers /////////////////////////
module dadda8_CLA(
	input [7:0] A,
	input [7:0] B,
	input [15:0] M,
	output [16:0] RES);
	
	genvar i;
	wire [7:0][7:0] P;
	wire [1:0][15:0] PRE;
	gen_part_products U1(A,B,P);
	dadda_processing_block_8 U2(P,M,PRE);
	CLA16 adder16_CLA (.sum(RES[15:0]), .cout(RES[16]), .a(PRE[1]), .b(PRE[0])); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
	
endmodule

module dadda8_RCA(
	input [7:0] A,
	input [7:0] B,
	input [15:0] M,
	output [16:0] RES);
	
	genvar i;
	wire [7:0][7:0] P;
	wire [1:0][15:0] PRE;
	gen_part_products U1(A,B,P);
	dadda_processing_block_8 U2(P,M,PRE);
	RCA16 adder16_CLA (.sum(RES[15:0]), .cout(RES[16]), .a(PRE[1]), .b(PRE[0])); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
	
endmodule

module dadda8_CSelA(
	input [7:0] A,
	input [7:0] B,
	input [15:0] M,
	output [16:0] RES);
	
	genvar i;
	wire [7:0][7:0] P;
	wire [1:0][15:0] PRE;
	gen_part_products U1(A,B,P);
	dadda_processing_block_8 U2(P,M,PRE);
	CSelA16 adder16_CLA (.sum(RES[15:0]), .cout(RES[16]), .a(PRE[1]), .b(PRE[0])); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
	
endmodule

module dadda8_CSkipA(
	input [7:0] A,
	input [7:0] B,
	input [15:0] M,
	output [16:0] RES);
	
	genvar i;
	wire [7:0][7:0] P;
	wire [1:0][15:0] PRE;
	gen_part_products U1(A,B,P);
	dadda_processing_block_8 U2(P,M,PRE);
	CSkipA16 adder16_CLA (.sum(RES[15:0]), .cout(RES[16]), .a(PRE[1]), .b(PRE[0])); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
	
endmodule

module dadda8_KSA(
	input [7:0] A,
	input [7:0] B,
	input [15:0] M,
	output [16:0] RES);
	
	genvar i;
	wire [7:0][7:0] P;
	wire [1:0][15:0] PRE;
	gen_part_products U1(A,B,P);
	dadda_processing_block_8 U2(P,M,PRE);
	KSA16 adder16_CLA (.sum(RES[15:0]), .cout(RES[16]), .a(PRE[1]), .b(PRE[0])); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
	
endmodule

/////////////////////////////////////////////////////////16 bit multipliers ////////////////////////////////////////

module dadda16_CLA(
    input [15:0] A,B,
    output [32:0] prod   
    );
    
    wire pp[15:0][15:0];
	wire [31:0] to_FA [1:0];
	generate_partial_products_16 pp1(.x(A), .y(B), .p(pp)); 
	dadda_processing_block_16 mul1(.pp(pp),.to_FA (to_FA));
	CLA32 cla1(.sum(prod[31:0]), .cout(prod[32]), .a(to_FA[0]), .b(to_FA[1])); //CLA32 RCA32 CSelA32 CSkipA32 KSA32

endmodule

module dadda16_RCA(
    input [15:0] A,B,
    output [32:0] prod   
    );
    
    wire pp[15:0][15:0];
	wire [31:0] to_FA [1:0];
	generate_partial_products_16 pp1(.x(A), .y(B), .p(pp)); 
	dadda_processing_block_16 mul1(.pp(pp),.to_FA (to_FA));
	RCA32 cla1(.sum(prod[31:0]), .cout(prod[32]), .a(to_FA[0]), .b(to_FA[1])); //CLA32 RCA32 CSelA32 CSkipA32 KSA32

endmodule

module dadda16_CSelA(
    input [15:0] A,B,
    output [32:0] prod   
    );
    
    wire pp[15:0][15:0];
	wire [31:0] to_FA [1:0];
	generate_partial_products_16 pp1(.x(A), .y(B), .p(pp)); 
	dadda_processing_block_16 mul1(.pp(pp),.to_FA (to_FA));
	CSelA32 cla1(.sum(prod[31:0]), .cout(prod[32]), .a(to_FA[0]), .b(to_FA[1])); //CLA32 RCA32 CSelA32 CSkipA32 KSA32

endmodule

module dadda16_CSkipA(
    input [15:0] A,B,
    output [32:0] prod   
    );
    
    wire pp[15:0][15:0];
	wire [31:0] to_FA [1:0];
	generate_partial_products_16 pp1(.x(A), .y(B), .p(pp)); 
	dadda_processing_block_16 mul1(.pp(pp),.to_FA (to_FA));
	CSkipA32 cla1(.sum(prod[31:0]), .cout(prod[32]), .a(to_FA[0]), .b(to_FA[1])); //CLA32 RCA32 CSelA32 CSkipA32 KSA32

endmodule

module dadda16_KSA(
    input [15:0] A,B,
    output [32:0] prod   
    );
    
    wire pp[15:0][15:0];
	wire [31:0] to_FA [1:0];
	generate_partial_products_16 pp1(.x(A), .y(B), .p(pp)); 
	dadda_processing_block_16 mul1(.pp(pp),.to_FA (to_FA));
	KSA32 cla1(.sum(prod[31:0]), .cout(prod[32]), .a(to_FA[0]), .b(to_FA[1])); //CLA32 RCA32 CSelA32 CSkipA32 KSA32

endmodule
