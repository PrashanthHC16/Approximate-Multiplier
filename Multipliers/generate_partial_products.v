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

module gen_part_products(  // from dadda 8 github
	input [7:0] A,
	input [7:0] B,
	output[7:0][7:0] P); 	//portlist can be 2D array in verilog 
	genvar i;
	generate
		for(i = 0; i < 8; i = i +1) begin:part_product
			assign P[i][0] = A[0] & B[i] ;
			assign P[i][1] = A[1] & B[i] ;
			assign P[i][2] = A[2] & B[i] ;
			assign P[i][3] = A[3] & B[i] ;
			assign P[i][4] = A[4] & B[i] ;
			assign P[i][5] = A[5] & B[i] ;
			assign P[i][6] = A[6] & B[i] ;
			assign P[i][7] = A[7] & B[i] ;
		end
	endgenerate
endmodule

///////////////////////////////////////// module built by me //////////////////////////////////

//////////////////////////////////////// full bits partial products ///////////////////////////
module generate_partial_products_8(
	input [7:0]x,
	input [7:0]y,
	output P[7:0][7:0] ); 	//portlist can be 2D array in verilog 
	genvar i,j;
	generate
		for(i = 0; i < 8; i = i +1) begin:part_product
		  for(j = 0; j < 8; j = j +1) begin
			assign P[i][j] = x[j] & y[i] ;
		  end
		end
	endgenerate
endmodule

//module generate_partial_products_12(
//	input [11:0] x,
//	input [11:0] y,
//	output P[11:0][11:0]); 	//portlist can be 2D array in verilog 
//	genvar i,j;
//	generate
//		for(i = 0; i < 12; i = i +1) begin:part_product
//			for(j = 0; j < 12; j = j +1) 
//			  assign P[i][j] = x[j] & y[i] ;
//		end
//	endgenerate
//endmodule

module generate_partial_products_16(
	input [15:0] x,
	input [15:0] y,
	output p[15:0][15:0] ); 	//portlist can be 2D array in verilog 
	genvar i,j;
	generate
		for(i = 0; i < 16; i = i +1) begin:part_product
			for(j = 0; j < 16; j = j +1) begin
			  assign p[i][j] = x[j] & y[i] ;
			end
		end
	endgenerate
endmodule

//module generate_partial_products_20(
//	input [19:0] x,
//	input [19:0] y,
//	output P[19:0][19:0]); 	//portlist can be 2D array in verilog 
//	genvar i,j;
//	generate
//		for(i = 0; i < 20; i = i +1) begin:part_product
//			for(j = 0; j < 20; j = j +1) 
//			  assign P[i][j] = x[j] & y[i] ;
//		end
//	endgenerate
//endmodule

///////////////////////////////////////// truncated partial products ////////////////////////

module generate_partial_products_8_trunc(
    input zero,
	input [7:0]x,
	input [7:0]y,
	output P[7:0][7:0] ); 	//portlist can be 2D array in verilog 
	genvar i,j;
	generate
		for(i = 0; i < 8; i = i +1) begin:part_product
		  for(j = 0; j < 8; j = j +1) begin
			if((i+j) > 6)             begin  assign P[i][j] = x[j] & y[i] ;       end
            else if((i==0) && (j==0)) begin  assign P[i][j] = zero & (x[i] & y[j]); end
            else begin                       assign P[i][j] = 1'b0;               end
		  end
		end
	endgenerate
	
endmodule

module generate_partial_products_16_trunc(
    input zero,
	input [15:0] x,
	input [15:0] y,
	output p[15:0][15:0] ); 	//portlist can be 2D array in verilog 
	genvar i,j;
	generate
		for(i = 0; i < 16; i = i +1) begin:part_product
			for(j = 0; j < 16; j = j +1) begin
			if((i+j) > 14)  begin assign p[i][j] = x[j] & y[i] ; end
			else if((i==0) && (j==0)) begin  assign p[i][j] = zero & (x[i] & y[j]); end
            else begin                       assign p[i][j] = 1'b0;               end
            end
		end
	endgenerate
	assign p[0][0] = 1'b0 & x[0] & y[0];
endmodule

//module generate_partial_products_12_trunc(
//	input [11:0] x,
//	input [11:0] y,
//	output P[11:0][11:0]); 	//portlist can be 2D array in verilog 
//	genvar i,j;
//	generate
//		for(i = 0; i < 12; i = i +1) begin:part_product
//			for(j = 0; j < 12; j = j +1) 
//			if((i+j) > 10)  begin assign p[i][j] = x[j] & y[i] ; end
//			else if((i==0) && (j==0)) begin  assign p[i][j] = zero & (x[i] & y[j]); end
//          else begin                       assign p[i][j] = 1'b0;               end
//		end
//	endgenerate
//endmodule

//module generate_partial_products_20_trunc(
//	input [19:0] x,
//	input [19:0] y,
//	output P[19:0][19:0]); 	//portlist can be 2D array in verilog 
//	genvar i,j;
//	generate
//		for(i = 0; i < 20; i = i +1) begin:part_product
//			for(j = 0; j < 20; j = j +1) 
//			if((i+j) > 18)  begin assign p[i][j] = x[j] & y[i] ; end
//			else if((i==0) && (j==0)) begin  assign p[i][j] = zero & (x[i] & y[j]); end
//          else begin                       assign p[i][j] = 1'b0;               end
//		end
//	endgenerate
//endmodule