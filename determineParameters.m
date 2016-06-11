function [ numberOfIterations, lambda1, lambda2, nu, initialLSF ] = determineParameters( imName )
% imName: image file name, (can be 1.bmp, 2.bmp, 3.bmp, 4.bmp, 5.bmp)
% numberOfIterations: number of iterations that will be used in the algorithm
% lambda1, lambda2: positive constants for local intensity fitting energy
% nu: coefficient of the length term
% initialLSF: initial level set function
% This function determines these parameters for each image

image = imread(imName);
[a, b] = size(image);
if(imName == '1.bmp')
    numberOfIterations = 1000;
    lambda1 = 1.0;
    lambda2 = 3.0;
    nu = 0.004*255*255;
    initialLSF = ones(a, b).*2;
    initialLSF(30:70, 30:90) = -2;
elseif(imName == '2.bmp')
    numberOfIterations = 200;
    lambda1 = 1.0;
    lambda2 = 1.0;
    nu = 0.002*255*255;
    initialLSF = ones(a, b).*2;
    initialLSF(26:32, 28:34) = -2;
elseif(imName == '3.bmp')
    numberOfIterations = 300;
    lambda1 = 1.0;
    lambda2 = 1.0;
    nu = 0.003*255*255;
    initialLSF = ones(a, b).*2;
    initialLSF(15:78, 32:95) = -2;
elseif(imName == '4.bmp')
    numberOfIterations = 150;
    lambda1 = 1.0;
    lambda2 = 1.0;
    nu = 0.001*255*255;
    initialLSF = ones(a, b).*2;
    initialLSF(53:77, 46:70) = -2;
elseif(imName == '5.bmp')
    numberOfIterations = 220;
    lambda1 = 1.0;
    lambda2 = 1.0;
    nu = 0.001*255*255;
    initialLSF = ones(a, b).*2;
    initialLSF(47:60, 86:99) = -2;
end

end

