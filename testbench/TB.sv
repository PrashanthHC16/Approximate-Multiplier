
///////////////////////////////////////////////////////////////////////////////////////////////////
// Owned by : Prashanth H C, Prashanth.C@iiitb.ac.in / prashanth.c@iiitb.org
// Complete implementation : https://github.com/PrashanthHC16/Approximate-Multipliers
//
// 2021 March,April
//
// Part of paper "Design and analysis of approximate multiplier designs based on multiplestage compressor architecture"
//
///////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module test_TB_8x8();

	reg [7:0] A;
	reg [7:0] B;
	
	wire [15:0]exactprod8;
	wire [15:0]approxprod8;
	wire [15:0]approxprod8_1step;
	wire [15:0]truncapproxprod8;
	wire [15:0]truncapproxprod8_1step;
	
	dadda8 dadda8( .A(A), .B(B),.M(0), .RES(exactprod8)    );
	top8 approx_mult8( .x(A), .y(B), .prod(approxprod8)    );
	top8_trunc truncapprox_mult8( .x(A), .y(B), .prod(truncapproxprod8)    );
    top8_1step approx_mult8_1step( .x(A), .y(B), .prod(approxprod8_1step)    );
    top8_trunc_1step approx_mult8_1step_trunc( .x(A), .y(B), .prod(truncapproxprod8_1step)    );
    
    integer i,j,f;
    
    initial 
    begin
    A = 8'h0;
    B = 8'h0;

	#1;
    f = $fopen("Result8.txt","wb");
    $fwrite(f,"A,B,exactprod8,approxprod8,truncapproxprod8,approxprod8_1step,truncapproxprod8_1step\n");
    for(i=0; i<256; i=i+1)
        begin
        for(j=0;j<256;j=j+1) begin
            A = i;//,$urandom_range(0,65536)};16'ha710,16'hffff
            B = j;//,$urandom_range(0,65536)};16'h0000,16'ha710
            #1;
            $fwrite(f,"%h,%h,%h,%h,%h,%h,%h\n",A,B,exactprod8,approxprod8,truncapproxprod8,approxprod8_1step,truncapproxprod8_1step);
        end
        end
 //   $fwrite(f,"No. of combinations = %d\n", comb);
    #1;
    $fclose(f);
    //$display("error count = %d\n", err_count);
    end
endmodule

module test_TB_16x16();

	reg [15:0] A;
	reg [15:0] B;
	
	wire [32:0]exactprod16;
	wire [32:0]approxprod16;
	wire [32:0]truncapproxprod16;
	
	wire [32:0]approxprod16_1step;
	wire [32:0]truncapproxprod16_1step;
	
	wire [32:0]approxprod16_2step;
	wire [32:0]truncapproxprod16_2step;
	
	dadda16 dadda16( .A(A), .B(B), .prod(exactprod16)    );
	top16 approx_mult16( .x(A), .y(B), .prod(approxprod16)    );
	top16_trunc truncapprox_mult16( .x(A), .y(B), .prod(truncapproxprod16)    );
    top16_1step approx_mult16_1step( .x(A), .y(B), .prod(approxprod16_1step)    );
    top16_trunc_1step approx_mult16_1step_trunc( .x(A), .y(B), .prod(truncapproxprod16_1step)    );
    top16_2step approx_mult16_2step( .x(A), .y(B), .prod(approxprod16_2step)    );
    top16_trunc_2step approx_mult16_2step_trunc( .x(A), .y(B), .prod(truncapproxprod16_2step)    );
    
    integer i,j,f;
    
    initial 
    begin
    A = 16'h0;
    B = 16'h0;
	//err_count = 0;
	#1;
    f = $fopen("Result16.txt","wb");
    //#1
    $fwrite(f,"A,B,exactprod16,approxprod16,truncapproxprod16,approxprod16_1step,truncapproxprod16_1step,approxprod16_2step,truncapproxprod16_2step\n");
    //#1;
    j=100*100;
    for(i=0; i<j; i=i+1)
        begin
        A = $urandom_range(16'h0000,16'hffff);//,$urandom_range(0,65536)};16'ha710,16'hffff
        B = $urandom_range(16'h0000,16'hffff);//,$urandom_range(0,65536)};16'h0000,16'ha710
        #1;
        $fwrite(f,"%h,%h,%h,%h,%h,%h,%h,%h,%h\n",A,B,exactprod16,approxprod16,truncapproxprod16,approxprod16_1step,truncapproxprod16_1step,approxprod16_2step,truncapproxprod16_2step);
        end
 //   $fwrite(f,"No. of combinations = %d\n", comb);
    #1;
    $fclose(f);
    //$display("error count = %d\n", err_count);
    end
        
endmodule
