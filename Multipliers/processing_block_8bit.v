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

/////////////////////////////////////// 8 bitdadda processing block ///////////////////////////////
module dadda_processing_block_8(
	input [7:0][7:0] P,
	input [15:0] M,
	output [1:0][15:0] PRE); //pre for pre result
	
	wire [47:0] fs,fc;	//wires for intermediate full adders & carry
	wire [7:0] hs,hc; 	//wires for intermediate half adder & carry

	genvar i; 		//generate variable for use in generate loop

	//for the connections given in the code, refer to the file 
	//"Dadda design.pdf" attached 
	
	//level 1 design	
	half_adder ha0(P[4][1],P[5][0],hs[0],hc[0]);
	
	half_adder ha1(P[2][4],P[3][3],hs[1],hc[1]);
	full_adder fa0(P[4][2],P[5][1],P[6][0],fs[0],fc[0]);

	full_adder fa2(P[5][2],P[6][1],P[7][0],fs[2],fc[2]);
	full_adder fa1(P[2][5],P[3][4],P[4][3],fs[1],fc[1]);
	half_adder ha2(P[0][7],P[1][6],hs[2],hc[2]);
	
	full_adder fa4(P[5][3],P[6][2],P[7][1],fs[4],fc[4]);
	full_adder fa3(P[2][6],P[3][5],P[4][4],fs[3],fc[3]);
	half_adder ha3(M[8],P[1][7],hs[3],hc[3]);
	
	
	full_adder fa6(P[5][4],P[6][3],P[7][2],fs[6],fc[6]);
	full_adder fa5(P[2][7],P[3][6],P[4][5],fs[5],fc[5]);
	
	full_adder fa7(P[5][5],P[6][4],P[7][3],fs[7],fc[7]);

	//level 2 adders
	half_adder ha4(P[3][0],P[2][1],hs[4],hc[4]);
	
	half_adder ha5(P[0][4],P[1][3],hs[5],hc[5]);
	full_adder fa8(P[2][2],P[3][1],P[4][0],fs[8],fc[8]);

	full_adder fa9(hs[0],P[0][05],P[1][4],fs[9],fc[9]);
	full_adder fa10(P[2][3],P[3][2],M[5],fs[10],fc[10]);

	full_adder fa11(fs[0],hc[0],hs[1],fs[11],fc[11]);
	full_adder fa12(P[0][6],M[6],P[1][5],fs[12],fc[12]);

	full_adder fa13(fs[1],fc[0],fs[2],fs[13],fc[13]);
	full_adder fa14(hc[1],hs[2],M[7],fs[14],fc[14]);
	
	full_adder fa15(fs[3],fc[1],fs[4],fs[15],fc[15]);
	full_adder fa16(fc[2],hs[3],hc[2],fs[16],fc[16]);

	full_adder fa17(fs[5],fc[3],fs[6],fs[17],fc[17]);
	full_adder fa18(fc[4],M[9],hc[3],fs[18],fc[18]);

	full_adder fa19(M[10],fc[5],P[3][7],fs[19],fc[19]);
	full_adder fa20(fc[6],fs[7],P[4][6],fs[20],fc[20]);

	full_adder fa21(M[11],P[4][7],P[5][6],fs[21],fc[21]);
	full_adder fa22(P[6][5],P[7][4],fc[7],fs[22],fc[22]);

	full_adder fa23(P[5][7],P[6][6],P[7][5],fs[23],fc[23]);

	//level 3
	half_adder ha6(P[1][1],P[2][0],hs[6],hc[6]);
	
	full_adder fa24(M[3],P[0][3],P[1][2],fs[24],fc[24]);
	full_adder fa25(hc[4],hs[5],M[4],fs[25],fc[25]);
	full_adder fa26(fc[8],fs[10],hc[5],fs[26],fc[26]);
	
	full_adder fa27(fc[9],fs[12],fc[10],fs[27],fc[27]);
	full_adder fa28(fc[11],fs[14],fc[12],fs[28],fc[28]);
	full_adder fa29(fc[13],fs[16],fc[14],fs[29],fc[29]);
	full_adder fa30(fc[15],fs[18],fc[16],fs[30],fc[30]);
	full_adder fa31(fc[17],fs[20],fc[18],fs[31],fc[31]);
	full_adder fa32(fc[19],fs[22],fc[20],fs[32],fc[32]);
	full_adder fa33(fc[21],M[12],fc[22],fs[33],fc[33]);
	full_adder fa34(M[13],P[6][7],P[7][6],fs[34],fc[34]);
		
	//level 4
	//i need to jus pass through some wires 
	and pass1(PRE[1][1],M[1],1'b1);
	and pass2(PRE[1][0],P[0][0],1'b1);

	and pass3(PRE[0][0],M[0],1'b1);
	and pass4(PRE[0][15],M[15],1'b1);
	
	half_adder ha7(P[0][1],P[1][0],PRE[0][1],PRE[1][2]);
	
	full_adder fa35(hs[6],M[2],P[0][2],PRE[0][2],PRE[1][3]);
	
	full_adder fa36(fs[24],hc[6],hs[4],PRE[0][3],PRE[1][4]);
	full_adder fa37(fs[25],fc[24],fs[8],PRE[0][4],PRE[1][5]);
	full_adder fa38(fs[26],fc[25],fs[9],PRE[0][5],PRE[1][6]);
	full_adder fa39(fs[27],fc[26],fs[11],PRE[0][6],PRE[1][7]);
	full_adder fa40(fs[28],fc[27],fs[13],PRE[0][7],PRE[1][8]);
	full_adder fa41(fs[29],fc[28],fs[15],PRE[0][8],PRE[1][9]);
	full_adder fa42(fs[30],fc[29],fs[17],PRE[0][9],PRE[1][10]);
	full_adder fa43(fs[31],fc[30],fs[19],PRE[0][10],PRE[1][11]);
	full_adder fa44(fs[32],fc[31],fs[21],PRE[0][11],PRE[1][12]);
	full_adder fa45(fs[33],fc[32],fs[23],PRE[0][12],PRE[1][13]);
	full_adder fa46(fs[34],fc[33],fc[23],PRE[0][13],PRE[1][14]);
	full_adder fa47(M[14],fc[34],P[7][7],PRE[0][14],PRE[1][15]);
	
endmodule


////////////////////////////////////////////// 8 bit 1 step processing block //////////////////////
module processing_block_8_1step(
input p[7:0][7:0],
output [14:0]out1,
output [14:0]out2
    );  

    ////////////////////////////////////////// PP REDUCTION STEP ONE   ////////////////////////  
    wire r[14:0][5:0] ; // outputs of first reduction

    assign r[0][0] = p[0][0];                                                 // column 0
    assign r[1][0] = p[1][0]; assign r[1][1] = p[0][1];                       // column 1
    compressor3_2 c1(.p({p[2][0],p[1][1],p[0][2]}),                                         .w({r[2][0],r[2][1]}));   // coulmn 2
    compressor4_2 c2(.p({p[3][0],p[2][1],p[1][2],p[0][3]}) ,                                .w({r[3][0],r[3][1]}) );  // column
    compressor5_3 c3(.p({p[4][0],p[3][1],p[2][2],p[1][3],p[0][4]}) ,                        .w({r[4][0],r[4][1],r[4][2]}) );  //column 4
    compressor6_3 c4(.p({p[5][0],p[4][1],p[3][2],p[2][3],p[1][4],p[0][5]}) ,                .w({r[5][0],r[5][1],r[5][2]}) );  // column 5
    compressor7_4 c5(.p({p[6][0],p[5][1],p[4][2],p[3][3],p[2][4],p[1][5],p[0][6]}) ,        .w({r[6][0],r[6][1],r[6][2],r[6][3]}) );  // column 6
    compressor8_4 c6(.p({p[7][0],p[6][1],p[5][2],p[4][3],p[3][4],p[2][5],p[1][6],p[0][7]}) ,.w({r[7][0],r[7][1],r[7][2],r[7][3]}) );  // column 7 LSP ends
    
    FA e1(.p({p[7][1],p[6][2],p[5][3]}), .w({r[9][0],r[8][0]}) );   //column 8
    HA e2(.p({p[4][4],p[3][5]}), .w({r[9][1],r[8][1]}) ); 
    assign r[8][2] = p[2][6]; assign r[8][3] = p[1][7]; 
        
    FA e3(.p({p[7][2],p[6][3],p[5][4]}), .w({r[10][0],r[9][2]})   ); //column 9
    FA e4(.p({p[4][5],p[3][6],p[2][7]}), .w({r[10][1],r[9][3]})   );
    
    FA e5(.p({p[7][3],p[6][4],p[5][5]}), .w({r[11][0],r[10][2]})   ); //column 10
    HA e6(.p({p[4][6],p[3][7]}), .w({r[11][1],r[10][3]}));
    
    FA e7(.p({p[7][4],p[6][5],p[5][6]}), .w({r[12][0],r[11][2]})   );//column 11
    assign r[11][3] = p[4][7];
    
    assign r[12][1] = p[7][5]; //column 12
    assign r[12][2] = p[6][6];
    assign r[12][3] = p[5][7];
     
    assign r[13][0] = p[7][6]; //column 13
    assign r[13][1] = p[6][7];
    
    assign r[14][0] = p[7][7]; //column 14
    //////////////////////////////////////////exact compressors////////////////////////////////////
    wire r1[14:0][1:0] ;
    
    assign r1[0][0] = r[0][0];// column 0
    assign r1[0][1] = 1'b0; // the third reduced pp doesnt provide value
    
    assign r1[1][0] = r[1][0];
    assign r1[1][1] = r[1][1];// column 1
    
    assign r1[2][0] = r[2][0];
    assign r1[2][1] = r[2][1];// column 2
    
    assign r1[3][0] = r[3][0];
    assign r1[3][1] = r[3][1];// column 3
	
	assign r1[4][1] = 1'b0;
    FA e8(.p({r[4][0],r[4][1],r[4][2]}), .w({r[5][3],r1[4][0]})   ); // column 4
	
	assign r1[5][1] = r[5][3];
    FA e9(.p({r[5][0],r[5][1],r[5][2]}), .w({r[6][4],r1[5][0]})   ); // column 5
	
	HA e10(.p({r[6][3],r[6][4]}), .w({r[7][5],r1[6][1]})   ); 
    FA e11(.p({r[6][0],r[6][1],r[6][2]}), .w({r[7][4],r1[6][0]})   ); // column 6
	
	FA e12(.p({r[7][0] ,r[7][1],r[7][2]}),   .w({r[8][4],r1[7][0]})   ); 
	FA e13(.p({r[7][3] ,r[7][4],r[7][5]}),   .w({r[8][5],r1[7][1]})   ); // column 7
	FA e14(.p({r[8][0] ,r[8][1],r[8][2]}),   .w({r[9][4],r1[8][0]})   ); 
	FA e15(.p({r[8][3] ,r[8][4],r[8][5]}),   .w({r[9][5],r1[8][1]})   ); // column 8
	FA e16(.p({r[9][0] ,r[9][1],r[9][2]}),   .w({r[10][4],r1[9][0]})   ); 
	FA e17(.p({r[9][3] ,r[9][4],r[9][5]}),   .w({r[10][5],r1[9][1]})   ); // column 9
	FA e18(.p({r[10][0],r[10][1],r[10][2]}), .w({r[11][4],r1[10][0]})   ); 
	FA e19(.p({r[10][3],r[10][4],r[10][5]}), .w({r[11][5],r1[10][1]})   ); // column 10
	FA e20(.p({r[11][0],r[11][1],r[11][2]}), .w({r[12][4],r1[11][0]})   ); 
	FA e21(.p({r[11][3],r[11][4],r[11][5]}), .w({r[12][5],r1[11][1]})   ); // column 11
	FA e22(.p({r[12][0],r[12][1],r[12][2]}), .w({r[13][2],r1[12][0]})   ); 
	FA e23(.p({r[12][3],r[12][4],r[12][5]}), .w({r[13][3],r1[12][1]})   ); // column 12
	
	assign r1[13][1] = r[13][3];
    FA e24(.p({r[13][0],r[13][1],r[13][2]}), .w({r[14][1],r1[13][0]})   ); // column 13
    
    assign r1[14][0] = r[14][0];
    assign r1[14][1] = r[14][1]; // column 14
	
	//////////////////////////////////////////// Outputs of processing block   ////////////////////////
	assign out1[0] = r1[0][0];    
    assign out1[1] = r1[1][0];
    assign out1[2] = r1[2][0];
    assign out1[3] = r1[3][0];
    assign out1[4] = r1[4][0];
    assign out1[5] = r1[5][0];
    assign out1[6] = r1[6][0];
    assign out1[7] = r1[7][0];
    assign out1[8] = r1[8][0];
    assign out1[9] = r1[9][0];
    assign out1[10] = r1[10][0];
    assign out1[11] = r1[11][0];
    assign out1[12] = r1[12][0];
    assign out1[13] = r1[13][0];
    assign out1[14] = r1[14][0];
	
    assign out2[0] = r1[0][1];    
    assign out2[1] = r1[1][1];
    assign out2[2] = r1[2][1];
    assign out2[3] = r1[3][1];
    assign out2[4] = r1[4][1];
    assign out2[5] = r1[5][1];
    assign out2[6] = r1[6][1];
    assign out2[7] = r1[7][1];
    assign out2[8] = r1[8][1];
    assign out2[9] = r1[9][1];
    assign out2[10] = r1[10][1];
    assign out2[11] = r1[11][1];
    assign out2[12] = r1[12][1];
    assign out2[13] = r1[13][1];
    assign out2[14] = r1[14][1];
      
endmodule

////////////////////////////////////////////// 8 bit 2 step processing block //////////////////////
module processing_block_8_2step(
input p[7:0][7:0],
output [14:0]out1,
output [14:0]out2
    );  
    wire out[14:0][1:0];
    ////////////////////////////////////////// PP REDUCTION STEP ONE   ////////////////////////  
    wire r[14:0][3:0] ; // outputs of first reduction
 
    assign r[0][0] = p[0][0];                                                 // column 0
    assign r[1][0] = p[1][0]; assign r[1][1] = p[0][1];                       // column 1
    compressor3_2 c1(.p({p[2][0],p[1][1],p[0][2]}),                                         .w({r[2][0],r[2][1]}));   // coulmn 2
    compressor4_2 c2(.p({p[3][0],p[2][1],p[1][2],p[0][3]}) ,                                .w({r[3][0],r[3][1]}) );  // column
    compressor5_3 c3(.p({p[4][0],p[3][1],p[2][2],p[1][3],p[0][4]}) ,                        .w({r[4][0],r[4][1],r[4][2]}) );  //column 4
    compressor6_3 c4(.p({p[5][0],p[4][1],p[3][2],p[2][3],p[1][4],p[0][5]}) ,                .w({r[5][0],r[5][1],r[5][2]}) );  // column 5
    compressor7_4 c5(.p({p[6][0],p[5][1],p[4][2],p[3][3],p[2][4],p[1][5],p[0][6]}) ,        .w({r[6][0],r[6][1],r[6][2],r[6][3]}) );  // column 6
    compressor8_4 c6(.p({p[7][0],p[6][1],p[5][2],p[4][3],p[3][4],p[2][5],p[1][6],p[0][7]}) ,.w({r[7][0],r[7][1],r[7][2],r[7][3]}) );  // column 7 LSP ends
    
    FA e1(.p({p[7][1],p[6][2],p[5][3]}), .w({r[9][0],r[8][0]}) );   //column 8
    HA e2(.p({p[4][4],p[3][5]}), .w({r[9][1],r[8][1]}) ); 
    assign r[8][2] = p[2][6]; assign r[8][3] = p[1][7]; 
        
    FA e3(.p({p[7][2],p[6][3],p[5][4]}), .w({r[10][0],r[9][2]})   ); //column 9
    FA e4(.p({p[4][5],p[3][6],p[2][7]}), .w({r[10][1],r[9][3]})   );
    
    FA e5(.p({p[7][3],p[6][4],p[5][5]}), .w({r[11][0],r[10][2]})   ); //column 10
    HA e6(.p({p[4][6],p[3][7]}), .w({r[11][1],r[10][3]}));
    
    FA e7(.p({p[7][4],p[6][5],p[5][6]}), .w({r[12][0],r[11][2]})   );//column 11
    assign r[11][3] = p[4][7];
    
    assign r[12][1] = p[7][5]; //column 12
    assign r[12][2] = p[6][6];
    assign r[12][3] = p[5][7];
     
    assign r[13][0] = p[7][6]; //column 13
    assign r[13][1] = p[6][7];
    
    assign r[14][0] = p[7][7]; //column 14
    
    ////////////////////////////////////////// PP REDUCTION STEP TWO   //////////////////////// 
    assign out[0][0] = r[0][0]; //column 0
    
    assign out[1][0] = r[1][0]; //column 1
    assign out[1][1] = r[1][1];
    
    assign out[2][0] = r[2][0]; //column 2
    assign out[2][1] = r[2][1];
    
    assign out[3][0] = r[3][0]; //column 3
    assign out[3][1] = r[3][1];
    
    compressor3_2 c7( .p({r[4][0] ,r[4][1] ,r[4][2]}),              .w({out[4][0],out[4][1]})); //column 4
    compressor3_2 c8( .p({r[5][0] ,r[5][1] ,r[5][2]}),              .w({out[5][0],out[5][1]})); //column 5
    compressor4_2 c9( .p({r[6][0] ,r[6][1] ,r[6][2] ,r[6][3]}) ,    .w({out[6][0],out[6][1]}) ); //column 6
    compressor4_2 c10(.p({r[7][0] ,r[7][1] ,r[7][2] ,r[7][3]}) ,    .w({out[7][0],out[7][1]}) ); //column 7
    compressor4_2 c11(.p({r[8][0] ,r[8][1] ,r[8][2] ,r[8][3]}) ,    .w({out[8][0],out[8][1]}) ); //column 8
    compressor4_2 c12(.p({r[9][0] ,r[9][1] ,r[9][2] ,r[9][3]}) ,    .w({out[9][0],out[9][1]}) ); //column 9
    compressor4_2 c13(.p({r[10][0],r[10][1],r[10][2],r[10][3]}) ,   .w({out[10][0],out[10][1]}) ); //column 10
    compressor4_2 c14(.p({r[11][0],r[11][1],r[11][2],r[11][3]}) ,   .w({out[11][0],out[11][1]}) ); //column 11
    
     FA e8(.p({r[12][0],r[12][1],r[12][2]}), .w({out[13][0],out[12][0]}) );   //column 12
     assign out[12][1] = r[12][3]; 
     
     HA e9(.p({r[13][0],r[13][1]}), .w({out[14][0],out[13][1]})); //column 13
     assign out[14][1] = r[14][0];  //column 14
    
    assign out[0][1] = 1'b0; // the second reduced pp doesnt provide value
	
    //////////////////////////////////////////// Outputs of processing block   ////////////////////////
    assign out1[0] = out[0][0];    
    assign out1[1] = out[1][0];
    assign out1[2] = out[2][0];
    assign out1[3] = out[3][0];
    assign out1[4] = out[4][0];
    assign out1[5] = out[5][0];
    assign out1[6] = out[6][0];
    assign out1[7] = out[7][0];
    assign out1[8] = out[8][0];
    assign out1[9] = out[9][0];
    assign out1[10] = out[10][0];
    assign out1[11] = out[11][0];
    assign out1[12] = out[12][0];
    assign out1[13] = out[13][0];
    assign out1[14] = out[14][0];
    
    assign out2[0] = out[0][1];    
    assign out2[1] = out[1][1];
    assign out2[2] = out[2][1];
    assign out2[3] = out[3][1];
    assign out2[4] = out[4][1];
    assign out2[5] = out[5][1];
    assign out2[6] = out[6][1];
    assign out2[7] = out[7][1];
    assign out2[8] = out[8][1];
    assign out2[9] = out[9][1];
    assign out2[10] = out[10][1];
    assign out2[11] = out[11][1];
    assign out2[12] = out[12][1];
    assign out2[13] = out[13][1];
    assign out2[14] = out[14][1];
    
endmodule