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


`define headerSize 1080 //for 512x512 Lena_Gray scale image
`define imageSize Img_W*Img_H

module tb_ImgProc;

localparam Datawidth = 8,
 Img_W  =   512,
 Img_H  =   512,

 K_W    =   3,
 K_H    =   3;
 
 
    reg [Datawidth-1:0]in_img_data;
    reg img_valid;
    
    wire [Datawidth-1:0]out_img_data;
    wire conv_valid;
    
    reg clk;
    reg reset;
    
    integer file,file1;
    integer i,j;
    
    integer sentCount,receivedCount;
    
    reg [Datawidth-1:0] headerData;
    
    initial
    begin
        clk = 1'b1;
        reset = 1'b1;
        #10
        reset = 1'b0; 
        
        
        file = $fopen("lena_original.bmp","rb");
        //file1 = $fopen("lena_GS_approx8.bmp","wb");
        //file1 = $fopen("lena_GS_approx8_trunc.bmp","wb");
        //file1 = $fopen("lena_GS_exact8.bmp","wb");
        file1 = $fopen("lena_GS_dadda8.bmp","wb");
                
        if(file == 0) 
        begin
             $display("Error: Please check file path!!");
             $finish;
        end
             
        for(i=0;i<`headerSize;i=i+1)
         begin
             $fscanf(file,"%c",headerData);
             $fwrite(file1,"%c",headerData);
         end
         
         sentCount = 0;
         
          img_valid = 0; 
          
          for(i=0;i<Img_W;i=i+1)
          for(j=0;j<Img_H;j=j+1)
           begin
               @(posedge clk);
               $fscanf(file,"%c",in_img_data); 
               sentCount = sentCount +1;                                  
           end
            
        //if(sentCount == `imageSize)
        
         img_valid  = 1; 
         $fclose(file);
         
          receivedCount = 0;
end

always @(posedge clk) 
begin        
        
         if(conv_valid)         
           begin
               $fwrite(file1,"%c",out_img_data);               
               receivedCount = receivedCount +1;
               $display("%d", receivedCount);                            
           end        
           
         if(receivedCount == `imageSize)  
         begin  
            $fclose(file1);         
            $stop;    
         end     
    
    end
        
    
ImgProc_mult_test  #(.Datawidth(Datawidth), .Img_W(Img_W), .Img_H(Img_H), .K_W(K_W), .K_H(K_H))inst1(

//ImgProc_real #(.Datawidth(Datawidth), .Img_W(Img_W), .Img_H(Img_H), .K_W(K_W), .K_H(K_H))inst1(

    .in_img_data(in_img_data),
    .img_valid(img_valid),
    
    .out_img_data(out_img_data),
    .conv_valid(conv_valid),
    
    .clk(clk),
    .reset(reset)
    
    );
    
always #5 clk = ~clk;

endmodule
