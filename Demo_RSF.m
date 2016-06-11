clc;clear all;close all;
imageName = input('Please indicate image file name on which image you want segmentation to be performed: ', 's'); %take image name
I = imread(imageName); % write image data to array
I = double(I(:,:,1));
[numberOfIterations lambda1 lambda2 nu initialLSF] = determineParameters(imageName); % function call to determine parameters for each image

%% opening a new figure
figure;
imagesc(I, [0,255]);
colormap(gray);
hold on;
axis off, axis equal;
title('Initial Contour');
%%
U = initialLSF; % set initial contour
[~,~] = contour(U,[0 0],'r'); % determine contour for initial LSF function
step = 0.1; % time step for illustration purposes
pause(step);

sigma = 3.0; % for scaling other parameters, sigma is taken as 3.0
K = fspecial('gaussian', 4*sigma + 1, sigma); % create Gaussian function
KI = conv2(I, K, 'same'); % convolution of Gaussian with constant function 1
KONE = conv2(ones(size(I)),K,'same');

%% iterative approach
for i=1:numberOfIterations
    % function call to determine LSF on each iteration
    U = RSF(U,I,K,KI,KONE,nu,step,1,lambda1,lambda2,1.0,1);
    if (mod(i,20) == 0)
        % display progress in each iteration with a time step for
        % illustration purposes
        pause(.1);
        imagesc(I, [0, 255]);
        colormap(gray);
        hold on;
        axis off, axis equal;
        [~, ~] = contour(U, [0 0], 'r');
        
        title([num2str(i) ' iteration']);
        hold off;
    end
end

% display the final image segmentation
imagesc(I, [0, 255]);
colormap(gray);
hold on;
axis off, axis equal
[~,~] = contour(U,[0 0],'r');
title(['Final contour, ' num2str(i) 'iterations']);

% display the final level set function
figure;
mesh(U);
title('Final level set function');