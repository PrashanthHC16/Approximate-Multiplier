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
///////////////////////////////////////////////////////////////////////////////////////////////////

clear ;

%%-------------------------------------------------------------------
%8x8

%h= [1	2	3	4	5	6	7	8	7	6	5	4	3	2	1];

%h = [1,2,2,2,3,3,4,4,4,4,4,4,4,2,1];

%%-------------------------------------------------------------------
%12x12

%h = [1 2 3 4 5 6 7 8 9 10 11 12 11 10 9 8 7 6 5 4 3 2 1]; 

%h = [1 2 2 2 3 3 4 4 5 5 6 6 6 6 6 6 6 6 6 4 3 2 1]; %19th onwards diff. cal

%h = [1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,1]; %for 2n-2, 2n-1 have to calc manually

%%-------------------------------------------------------------------
%16x16

%h = [1 2 3 4 5	6	7	8	9	10	11	12	13	14	15	16	15	14	13	12 11	10	9	8	7	6	5	4	3	2	1]; 

%h = [1,2,2,2,3,3,4,4,5,5,6,6,7,7,8,8,8,8,8,8,8,8,8,8,8,6,5,4,3,2,1];

%h = [1,2,2,2,2,2,2,2,3,3,3,3,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,2,1];

%%-------------------------------------------------------------------
%20x20

%h= [1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20	19	18	17	16	15	14	13	12	11	10	9	8	7	6	5	4	3	2	1];

%h = [1,2,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,10,10,10,10,10,10,10,10,10,10,10,8,7,6,5,4,3,2,1];

%h = [1,2,2,2,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,3,2,1];

h = [1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,1];

%%-------------------------------------------------------------------
n = (numel(h)+1)/2;

h_max = max(h);

h_max_next = ceil(h_max/2);


for k = 1:1:n  %-----LSP
    
    FA(k) = 0; HA(k) = 0; % C(k) = 0;
    
    if h(k) <= 2 %--changed to 1
        j(k) = 0; h_next(k) = h(k);
    else
        j(k) = h(k); h_next(k) = ceil(h(k)/2);        
    end
    
end


%C(n) = 0;

%calculating C


for k = n+1:1:(2*n-3) %-----MSP
    
     FA(k) = 0; HA(k) = 0; j(k) = 0;  C(k) = 0;
     
     h_next(k) = h(k);    
     
     % case1 :
     % C*
     C_1(k) = ceil((h(k)-(h_max_next - C(k-1)))/2);
    if(C_1(k) < 0)
         C_1(k) = 0;
    end
     % case2 :
     % C**
     C_max = h_max_next - ceil(h(k+2)/3);
     
     Cc(k+1) = C_max;     
     
     C_2(k) = 2*Cc(k+1) - h(k+1) + h_max_next ;
     
     if(C_2(k) < 0)
         C_2(k) = 0;
    end
     
     
     if C_2(k) < C_1(k) %approx. compressors are required
        
         C(k) = C_2(k); FA(k) = C_2(k);
         
         j(k) = 2*(h(k) - h_max_next - 2*FA(k) + C(k-1));
         
         if( j(k) == 2  && (h(k) - (3*FA(k)) >= 3))             
             j(k) = 3;             
         end
         
     else
         
         C(k) = C_1(k);
         
         if C(k) > 0 
            FA(k) = floor( (h(k) - h_max_next + C(k-1)) /2 ); %changed to floor
            HA(k) = C(k) - FA(k);             
         end 
         
     end
     
     h_next(k) = h(k) - 2*FA(k) - HA(k) - (j(k)-ceil(j(k)/2)) + C(k-1);  %changed to (j(k)-ceil(j(k)/2))  
        
        
end

    
