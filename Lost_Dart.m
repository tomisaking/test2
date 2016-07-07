function wrong = Lost_Dart(pS, pE, ori, CW)  



if (pS(1)-ori(1)>0)&(pS(2)-ori(2)>0)
    s_quadrant=1;   
elseif (pS(1)-ori(1)==0)&(pS(2)-ori(2)>0)
    s_quadrant=2;    
elseif (pS(1)-ori(1)<0)&(pS(2)-ori(2)>0)
    s_quadrant=3;    
elseif (pS(1)-ori(1)<0)&(pS(2)-ori(2)==0)
    s_quadrant=4;
elseif (pS(1)-ori(1)<0)&(pS(2)-ori(2)<0)
    s_quadrant=5;
elseif (pS(1)-ori(1)==0)&(pS(2)-ori(2)<0)
    s_quadrant=6;
elseif (pS(1)-ori(1)>0)&(pS(2)-ori(2)<0)
    s_quadrant=7;
elseif (pS(1)-ori(1)>0)&(pS(2)-ori(2)==0)
    s_quadrant=8;
elseif (pS(1)-ori(1)==0)&(pS(2)-ori(2)==0)
    s_quadrant=9;
 end   
    
if (pE(1)-ori(1)>0)&(pE(2)-ori(2)>0)
    e_quadrant=1;   
elseif (pE(1)-ori(1)==0)&(pE(2)-ori(2)>0)
    e_quadrant=2;    
elseif (pE(1)-ori(1)<0)&(pE(2)-ori(2)>0)
    e_quadrant=3;    
elseif (pE(1)-ori(1)<0)&(pE(2)-ori(2)==0)
    e_quadrant=4;
elseif (pE(1)-ori(1)<0)&(pE(2)-ori(2)<0)
    e_quadrant=5;
elseif (pE(1)-ori(1)==0)&(pE(2)-ori(2)<0)
    e_quadrant=6;
elseif (pE(1)-ori(1)>0)&(pE(2)-ori(2)<0)
    e_quadrant=7;
elseif (pE(1)-ori(1)>0)&(pE(2)-ori(2)==0)
    e_quadrant=8;
elseif (pE(1)-ori(1)==0)&(pE(2)-ori(2)==0)
    e_quadrant=9;
 end   
    
if (s_quadrant==1) & ((e_quadrant==8)| (e_quadrant==1 & CW==1 & pS(1)<pE(1)) | (e_quadrant==1 & CW==0 & pS(1)>pE(1)) | (e_quadrant==2))
    wrong=0;
elseif (s_quadrant==2) & ((e_quadrant==8)| (e_quadrant==1) | (e_quadrant==2) | (e_quadrant==3) | (e_quadrant==4))
    wrong=0;
elseif (s_quadrant==3) & ((e_quadrant==2)| (e_quadrant==3 & CW==1 & pS(1)<pE(1)) | (e_quadrant==3 & CW==0 & pS(1)>pE(1)) | (e_quadrant==4))
    wrong=0;
elseif (s_quadrant==4) & ((e_quadrant==2)| (e_quadrant==3) | (e_quadrant==4) | (e_quadrant==5) | (e_quadrant==6))
    wrong=0;
elseif (s_quadrant==5) & ((e_quadrant==4)| (e_quadrant==5 & CW==1 & pS(1)>pE(1)) | (e_quadrant==5 & CW==0 & pS(1)<pE(1)) | (e_quadrant==6))
    wrong=0;
elseif (s_quadrant==6) & ((e_quadrant==4)| (e_quadrant==5) | (e_quadrant==6) | (e_quadrant==7) | (e_quadrant==8))
    wrong=0;
elseif (s_quadrant==7) & ((e_quadrant==6)| (e_quadrant==7 & CW==1 & pS(1)>pE(1)) | (e_quadrant==7 & CW==0 & pS(1)<pE(1)) | (e_quadrant==8))
    wrong=0;
elseif (s_quadrant==8) & ((e_quadrant==6)| (e_quadrant==7) | (e_quadrant==8) | (e_quadrant==1) | (e_quadrant==2))
    wrong=0;
elseif (s_quadrant==9) & (e_quadrant==9)
    wrong=0;
else 
    wrong=1;
    if (wrong==1)
       fprintf('%d %d\n', s_quadrant, e_quadrant);
       fprintf('Start=(%.5f, %.5f)  End=(%.5f, %.5f) \n', pS(1), pS(2), pE(1), pE(2));
       msg = 'Some darts are over 90 degree';
       error(msg);
    end
        
end


An apple a day ,keeps the doctor away.

end
