///////////////////////////////////////////////////////////////////////////////////////////////////
// Owned by : Prashanth H C, prashanth.C@iiitb.ac.in / prashanth.c@iiitb.org
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

//////////////////////////////////////////////////////// 8 bit 1 step multipliers ///////////////////
module top8_1step_CLA16( input [7:0]x, input [7:0]y, output [16:0]prod    );
    wire p[7:0][7:0];
    wire [15:0]PRE1;
    wire [15:0]PRE2;
    
    assign PRE1[15] = 1'b0;
    assign PRE2[15] = 1'b0;
    
    generate_partial_products_8 generate_partial_products_8(.x(x),.y(y),.P(p));  
    processing_block_8_1step processing_block_8_1step( .p(p), .out1(PRE1[14:0]) ,.out2(PRE2[14:0]));      
    CLA16 CLA16 (.sum(prod[15:0]), .cout(prod[16]), .a(PRE1), .b(PRE2)); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
endmodule

module top8_1step_RCA16( input [7:0]x, input [7:0]y, output [16:0]prod    );
    wire p[7:0][7:0];
    wire [15:0]PRE1;
    wire [15:0]PRE2;
    
    assign PRE1[15] = 1'b0;
    assign PRE2[15] = 1'b0;
    
    generate_partial_products_8 generate_partial_products_8(.x(x),.y(y),.P(p));  
    processing_block_8_1step processing_block_8_1step( .p(p), .out1(PRE1[14:0]) ,.out2(PRE2[14:0]));      
    RCA16 RCA16 (.sum(prod[15:0]), .cout(prod[16]), .a(PRE1), .b(PRE2)); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
endmodule

module top8_1step_CSelA16( input [7:0]x, input [7:0]y, output [16:0]prod    );
    wire p[7:0][7:0];
    wire [15:0]PRE1;
    wire [15:0]PRE2;
    
    assign PRE1[15] = 1'b0;
    assign PRE2[15] = 1'b0;
    
    generate_partial_products_8 generate_partial_products_8(.x(x),.y(y),.P(p));  
    processing_block_8_1step processing_block_8_1step( .p(p), .out1(PRE1[14:0]) ,.out2(PRE2[14:0]));      
    CSelA16 CSelA16 (.sum(prod[15:0]), .cout(prod[16]), .a(PRE1), .b(PRE2)); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
endmodule

module top8_1step_CSkipA16( input [7:0]x, input [7:0]y, output [16:0]prod    );
    wire p[7:0][7:0];
    wire [15:0]PRE1;
    wire [15:0]PRE2;
    
    assign PRE1[15] = 1'b0;
    assign PRE2[15] = 1'b0;
    
    generate_partial_products_8 generate_partial_products_8(.x(x),.y(y),.P(p));  
    processing_block_8_1step processing_block_8_1step( .p(p), .out1(PRE1[14:0]) ,.out2(PRE2[14:0]));      
    CSkipA16 CSkipA16 (.sum(prod[15:0]), .cout(prod[16]), .a(PRE1), .b(PRE2)); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
endmodule

module top8_1step_KSA16( input [7:0]x, input [7:0]y, output [16:0]prod    );
    wire p[7:0][7:0];
    wire [15:0]PRE1;
    wire [15:0]PRE2;
    
    assign PRE1[15] = 1'b0;
    assign PRE2[15] = 1'b0;
    
    generate_partial_products_8 generate_partial_products_8(.x(x),.y(y),.P(p));  
    processing_block_8_1step processing_block_8_1step( .p(p), .out1(PRE1[14:0]) ,.out2(PRE2[14:0]));      
    KSA16 KSA16 (.sum(prod[15:0]), .cout(prod[16]), .a(PRE1), .b(PRE2)); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
endmodule

//////////////////////////////////////////////////////// 8 bit 1 step truncated multipliers ///////////////////
module top8_1step_CLA16_trunc( input [7:0]x, input [7:0]y, output [16:0]prod    );
    wire p[7:0][7:0];
    wire [15:0]PRE1;
    wire [15:0]PRE2;
    
    assign PRE1[15] = 1'b0;
    assign PRE2[15] = 1'b0;
    
    generate_partial_products_8_trunc generate_partial_products_8_trunc(.x(x),.y(y),.P(p));  
    processing_block_8_1step processing_block_8_1step( .p(p), .out1(PRE1[14:0]) ,.out2(PRE2[14:0]));      
    CLA16 CLA16 (.sum(prod[15:0]), .cout(prod[16]), .a(PRE1), .b(PRE2)); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
endmodule

module top8_1step_RCA16_trunc( input [7:0]x, input [7:0]y, output [16:0]prod    );
    wire p[7:0][7:0];
    wire [15:0]PRE1;
    wire [15:0]PRE2;
    
    assign PRE1[15] = 1'b0;
    assign PRE2[15] = 1'b0;
    
    generate_partial_products_8_trunc generate_partial_products_8_trunc(.x(x),.y(y),.P(p));  
    processing_block_8_1step processing_block_8_1step( .p(p), .out1(PRE1[14:0]) ,.out2(PRE2[14:0]));      
    RCA16 RCA16 (.sum(prod[15:0]), .cout(prod[16]), .a(PRE1), .b(PRE2)); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
endmodule

module top8_1step_CSelA16_trunc( input [7:0]x, input [7:0]y, output [16:0]prod    );
    wire p[7:0][7:0];
    wire [15:0]PRE1;
    wire [15:0]PRE2;
    
    assign PRE1[15] = 1'b0;
    assign PRE2[15] = 1'b0;
    
    generate_partial_products_8_trunc generate_partial_products_8_trunc(.x(x),.y(y),.P(p));  
    processing_block_8_1step processing_block_8_1step( .p(p), .out1(PRE1[14:0]) ,.out2(PRE2[14:0]));      
    CSelA16 CSelA16 (.sum(prod[15:0]), .cout(prod[16]), .a(PRE1), .b(PRE2)); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
endmodule

module top8_1step_CSkipA16_trunc( input [7:0]x, input [7:0]y, output [16:0]prod    );
    wire p[7:0][7:0];
    wire [15:0]PRE1;
    wire [15:0]PRE2;
    
    assign PRE1[15] = 1'b0;
    assign PRE2[15] = 1'b0;
    
    generate_partial_products_8_trunc generate_partial_products_8_trunc(.x(x),.y(y),.P(p));  
    processing_block_8_1step processing_block_8_1step( .p(p), .out1(PRE1[14:0]) ,.out2(PRE2[14:0]));      
    CSkipA16 CSkipA16 (.sum(prod[15:0]), .cout(prod[16]), .a(PRE1), .b(PRE2)); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
endmodule

module top8_1step_KSA16_trunc( input [7:0]x, input [7:0]y, output [16:0]prod    );
    wire p[7:0][7:0];
    wire [15:0]PRE1;
    wire [15:0]PRE2;
    
    assign PRE1[15] = 1'b0;
    assign PRE2[15] = 1'b0;
    
    generate_partial_products_8_trunc generate_partial_products_8_trunc(.x(x),.y(y),.P(p));  
    processing_block_8_1step processing_block_8_1step( .p(p), .out1(PRE1[14:0]) ,.out2(PRE2[14:0]));      
    KSA16 KSA16 (.sum(prod[15:0]), .cout(prod[16]), .a(PRE1), .b(PRE2)); //CLA16 RCA16 CSelA16 CSkipA16 KSA16
endmodule
/*
////////////////////////////////////////////////////// 16 bit 1 step multipliers ////////////////////////////////////////

module top16_1step_CLA32( input [15:0]x, input [15:0]y, output [32:0]prod    );
    wire p[15:0][15:0];
    wire [31:0]PRE1;
    wire [31:0]PRE2;
  
    assign PRE1[31] = 1'b0;
    assign PRE2[31] = 1'b0;

    generate_partial_products_16 generate_partial_products_16(.x(x),.y(y),.p(p));  
    processing_block_16_1step processing_block_16_1step( .p(p), .out1(PRE1[30:0]) ,.out2(PRE2[30:0]));    
    CLA32 CLA32 (.sum(prod[31:0]), .cout(prod[32]), .a(PRE1), .b(PRE2)); //CLA32 RCA32 CSelA32 CSkipA32 KSA32
endmodule

module top16_1step_RCA32( input [15:0]x, input [15:0]y, output [32:0]prod    );
    wire p[15:0][15:0];
    wire [31:0]PRE1;
    wire [31:0]PRE2;
  
    assign PRE1[31] = 1'b0;
    assign PRE2[31] = 1'b0;

    generate_partial_products_16 generate_partial_products_16(.x(x),.y(y),.p(p));  
    processing_block_16_1step processing_block_16_1step( .p(p), .out1(PRE1[30:0]) ,.out2(PRE2[30:0]));    
    RCA32 RCA32 (.sum(prod[31:0]), .cout(prod[32]), .a(PRE1), .b(PRE2)); //CLA32 RCA32 CSelA32 CSkipA32 KSA32
endmodule

module top16_1step_CSelA32( input [15:0]x, input [15:0]y, output [32:0]prod    );
    wire p[15:0][15:0];
    wire [31:0]PRE1;
    wire [31:0]PRE2;
  
    assign PRE1[31] = 1'b0;
    assign PRE2[31] = 1'b0;

    generate_partial_products_16 generate_partial_products_16(.x(x),.y(y),.p(p));  
    processing_block_16_1step processing_block_16_1step( .p(p), .out1(PRE1[30:0]) ,.out2(PRE2[30:0]));    
    CSelA32 CSelA32 (.sum(prod[31:0]), .cout(prod[32]), .a(PRE1), .b(PRE2)); //CLA32 RCA32 CSelA32 CSkipA32 KSA32
endmodule

module top16_1step_CSkipA32( input [15:0]x, input [15:0]y, output [32:0]prod    );
    wire p[15:0][15:0];
    wire [31:0]PRE1;
    wire [31:0]PRE2;
  
    assign PRE1[31] = 1'b0;
    assign PRE2[31] = 1'b0;

    generate_partial_products_16 generate_partial_products_16(.x(x),.y(y),.p(p));  
    processing_block_16_1step processing_block_16_1step( .p(p), .out1(PRE1[30:0]) ,.out2(PRE2[30:0]));    
    CSkipA32 CSkipA32 (.sum(prod[31:0]), .cout(prod[32]), .a(PRE1), .b(PRE2)); //CLA32 RCA32 CSelA32 CSkipA32 KSA32
endmodule

module top16_1step_KSA32( input [15:0]x, input [15:0]y, output [32:0]prod    );
    wire p[15:0][15:0];
    wire [31:0]PRE1;
    wire [31:0]PRE2;
  
    assign PRE1[31] = 1'b0;
    assign PRE2[31] = 1'b0;

    generate_partial_products_16 generate_partial_products_16(.x(x),.y(y),.p(p));  
    processing_block_16_1step processing_block_16_1step( .p(p), .out1(PRE1[30:0]) ,.out2(PRE2[30:0]));    
    KSA32 KSA32 (.sum(prod[31:0]), .cout(prod[32]), .a(PRE1), .b(PRE2)); //CLA32 RCA32 CSelA32 CSkipA32 KSA32
endmodule

////////////////////////////////////////////////////// 16 bit 1 step truncated multipliers ////////////////////////////////////////

module top16_1step_CLA32_trunc( input [15:0]x, input [15:0]y, output [32:0]prod    );
    wire p[15:0][15:0];
    wire [31:0]PRE1;
    wire [31:0]PRE2;
  
    assign PRE1[31] = 1'b0;
    assign PRE2[31] = 1'b0;

    generate_partial_products_16_trunc generate_partial_products_16_trunc(.x(x),.y(y),.p(p));  
    processing_block_16_1step processing_block_16_1step( .p(p), .out1(PRE1[30:0]) ,.out2(PRE2[30:0]));    
    CLA32 CLA32 (.sum(prod[31:0]), .cout(prod[32]), .a(PRE1), .b(PRE2)); //CLA32 RCA32 CSelA32 CSkipA32 KSA32
endmodule

module top16_1step_RCA32_trunc( input [15:0]x, input [15:0]y, output [32:0]prod    );
    wire p[15:0][15:0];
    wire [31:0]PRE1;
    wire [31:0]PRE2;
  
    assign PRE1[31] = 1'b0;
    assign PRE2[31] = 1'b0;

    generate_partial_products_16_trunc generate_partial_products_16_trunc(.x(x),.y(y),.p(p));  
    processing_block_16_1step processing_block_16_1step( .p(p), .out1(PRE1[30:0]) ,.out2(PRE2[30:0]));    
    RCA32 RCA32 (.sum(prod[31:0]), .cout(prod[32]), .a(PRE1), .b(PRE2)); //CLA32 RCA32 CSelA32 CSkipA32 KSA32
endmodule

module top16_1step_CSelA32_trunc( input [15:0]x, input [15:0]y, output [32:0]prod    );
    wire p[15:0][15:0];
    wire [31:0]PRE1;
    wire [31:0]PRE2;
  
    assign PRE1[31] = 1'b0;
    assign PRE2[31] = 1'b0;

    generate_partial_products_16_trunc generate_partial_products_16_trunc(.x(x),.y(y),.p(p));  
    processing_block_16_1step processing_block_16_1step( .p(p), .out1(PRE1[30:0]) ,.out2(PRE2[30:0]));    
    CSelA32 CSelA32 (.sum(prod[31:0]), .cout(prod[32]), .a(PRE1), .b(PRE2)); //CLA32 RCA32 CSelA32 CSkipA32 KSA32
endmodule

module top16_1step_CSkipA32_trunc( input [15:0]x, input [15:0]y, output [32:0]prod    );
    wire p[15:0][15:0];
    wire [31:0]PRE1;
    wire [31:0]PRE2;
  
    assign PRE1[31] = 1'b0;
    assign PRE2[31] = 1'b0;

    generate_partial_products_16_trunc generate_partial_products_16_trunc(.x(x),.y(y),.p(p));  
    processing_block_16_1step processing_block_16_1step( .p(p), .out1(PRE1[30:0]) ,.out2(PRE2[30:0]));    
    CSkipA32 CSkipA32 (.sum(prod[31:0]), .cout(prod[32]), .a(PRE1), .b(PRE2)); //CLA32 RCA32 CSelA32 CSkipA32 KSA32
endmodule

module top16_1step_KSA32_trunc( input [15:0]x, input [15:0]y, output [32:0]prod    );
    wire p[15:0][15:0];
    wire [31:0]PRE1;
    wire [31:0]PRE2;
  
    assign PRE1[31] = 1'b0;
    assign PRE2[31] = 1'b0;

    generate_partial_products_16_trunc generate_partial_products_16_trunc(.x(x),.y(y),.p(p));  
    processing_block_16_1step processing_block_16_1step( .p(p), .out1(PRE1[30:0]) ,.out2(PRE2[30:0]));    
    KSA32 KSA32 (.sum(prod[31:0]), .cout(prod[32]), .a(PRE1), .b(PRE2)); //CLA32 RCA32 CSelA32 CSkipA32 KSA32
endmodule
*/