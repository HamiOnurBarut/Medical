function U = RSF(initialLSF,image,Ksigma,KI,KONE,nu,step,mu,lambda1,lambda2,epsilon,numberOfIterations)
% This (RSF.m) function is taken from http://www.bic.mni.mcgill.ca/brainweb/ website
% It determines region-scalable fitting (RSF) energy functional based on
% contour and 2 fitting functions that are located at inner and outer
% regions of the contour which can be interpreted as image intensities on
% these regions.
% initialLSF: initial level set function that will be used.
% image: Image data read from specified image file.
% Ksigma: Gaussian Kernel Function
% lambda1, lambda2: They are positive constants
% U: it is stated as subregion

U=initialLSF;
for i=1:numberOfIterations
    [a,b] = size(U);
    U([1 a],[1 b]) = U([3 a-2],[3 b-2]);  
    U([1 a],2:end-1) = U([3 a-2],2:end-1);          
    U(2:end-1,[1 b]) = U(2:end-1,[3 b-2]);  
    
    [ux,uy] = gradient(U);                                  
    normDu = sqrt(ux.^2+uy.^2+1e-10);                       % the norm of the gradient plus a small possitive number 
                                                            % to avoid division by zero in the following computation.
    Nx = ux./normDu;                                       
    Ny = uy./normDu;
    [nxx,~] = gradient(Nx);                              
    [~,nyy] = gradient(Ny);                              
    K = nxx+nyy;
    
    DrcU=(epsilon/pi)./(epsilon^2.+U.^2);               

    Hu=0.5*(1+(2/pi)*atan(U./epsilon));                     

    I=image.*Hu;
    c1=conv2(Hu,Ksigma,'same');                             
    c2=conv2(I,Ksigma,'same');                              
    f1=c2./(c1);                                            
    f2=(KI-c2)./(KONE-c1);                                   
                                                            


    %%% compute lambda1*e1-lambda2*e2
    s1=lambda1.*f1.^2-lambda2.*f2.^2;                   % compute lambda1*e1-lambda2*e2
    s2=lambda1.*f1-lambda2.*f2;
    dataForce=(lambda1-lambda2)*KONE.*image.*image+conv2(s1,Ksigma,'same')-2.*image.*conv2(s2,Ksigma,'same');
                                                        
    A=-DrcU.*dataForce;                                 
    P=mu*(4*del2(U)-K);                                 % compute the laplacian (d^2u/dx^2 + d^2u/dy^2)
    L=nu.*DrcU.*K;                                      
    U=U+step*(L+P+A);                               
end
