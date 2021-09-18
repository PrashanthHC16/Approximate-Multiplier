///////////////////////////////////////////////////////////////////////////////////////////////////
// Owned by : Soujanya S R, soujanya.sr@iiitb.ac.in
// File distributed under MIT License.
// 2021 September
//
// Complete implementation : https://github.com/PrashanthHC16/Approximate-Multipliers
//
// Part of paper "Performance and Error Analysis of Approximate Multipliers of Different Configurations and Fast Adders"
// Authors : Prashanth H C, Soujanya S R, Bindu G Gowda, Madhav Rao
//
///////////////////////////////////////////////////////////////////////////////////////////////////\



`timescale 1ns / 1ps


module ImgProc_mult_test#(Datawidth = 8, Img_W = 512, Img_H = 512, K_W = 3, K_H = 3)(

    input [Datawidth-1:0]in_img_data,
    input img_valid,
    
    output reg [Datawidth-1:0]out_img_data,
    output reg conv_valid,
    
    input clk,
    input reset
    
    );
    
    
    reg [Datawidth-1:0] in_img [Img_W-1:0][Img_H-1:0];
    reg [20:0] sum; //8bitx8bit ->16bits; max val: 256,000 -> 18bits sufficient
    wire [(2*Datawidth)-1:0] prod;
    
    reg [Datawidth-1:0] filter_GS[2:0][2:0];
    
    reg [Datawidth-1:0] A,B;
    
        
    integer i,j,m,n;
    
  
    initial
    begin
    
    /*
        0.0947    0.1183    0.0947
        0.1183    0.1478    0.1183
        0.0947    0.1183    0.0947
    */
    
        filter_GS[0][0] =  95;   filter_GS[0][1] = 118;   filter_GS[0][2] = 95;
        filter_GS[1][0] = 118;   filter_GS[1][1] = 148;   filter_GS[1][2] = 118;
        filter_GS[2][0] =  95;   filter_GS[2][1] = 118;   filter_GS[2][2] = 95;
        
      
    end
    
    always @(posedge clk)
    begin
    if(reset)
    begin
        sum = 20'b0;
        conv_valid = 1'b0;        
    end
    else
    begin
        if(!img_valid) //read the image
        begin
            for(i = 0; i< Img_W; i=i+1)
            begin
            for(j = 0; j< Img_H; j=j+1)
            begin
                in_img[i][j] = in_img_data;
                @(posedge clk);                
            end 
            end   
            
        end
        
        
        else
        
        begin
        //for 510x510 header needs to be changed
//          for(i=0; i<Img_W-K_W+1; i=i+1)
//              for(j=0; j<Img_H-K_H+1; j=j+1)

              
              for(i=0; i<Img_W; i=i+1)
              for(j=0; j<Img_H; j=j+1)
              begin
                  sum <= 20'b0;
                  conv_valid = 1'b0;
                  for(m=0; m<K_W; m=m+1)
                  for(n=0 ; n<K_H; n=n+1)
                  begin
                   
                   //Gaussian Smoothing
                        //sum = sum + ( in_img[i+m][j+n] * filter_GS[m][n]);  
                        A = in_img[i+m][j+n];
                        B = filter_GS[m][n];
                        @(posedge clk);
                        $display("%d * %d = %d", A, B, prod);
                        sum = sum + prod;                      
                        
                  end
                  
                  sum = sum*0.001;
                  conv_valid = 1'b1;
                  out_img_data = sum;
                  @(posedge clk);
              end                          
        end  
    end
    end
        
     top_level mul1(.A(A), .B(B), .RES(prod), .M(17'b0)); //8x8 dadda
    //top8 mul1(.x(A), .y(B), .prod(prod));
   // top8_trunc mul1(.x(A), .y(B), .prod(prod));
    
    
    
endmodule
