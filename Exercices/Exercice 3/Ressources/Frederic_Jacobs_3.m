function Frederic_Jacobs_3()
clc
close all
clear all
gamma = 2.4;


function nM = normalizeMatrix(dataset)
    nM = dataset/max(max(max(dataset)));
end

function nM = normalizeImage(image)
    nM        = normalizeMatrix(image(:,:,1));
    nM(:,:,2) = normalizeMatrix(image(:,:,2));
    nM(:,:,3) = normalizeMatrix(image(:,:,3));
end

function gimshow(image)
    imshow(gCorrection(image, gamma));
end

function gCorrected = gCorrection(Im, gamma)
    Im = power(Im(:,:,:), 1/gamma);
    gCorrected = normalizeImage(Im);
end


function meanvalue = computeMean(imageChannel)
    meanvalue = mean(mean(mean(imageChannel)));
end

%% Initialization
Im1 = imread('Im1.jpg');
Im1 = im2double(Im1);

Im2 = imread('Im2.jpg');
Im2 = im2double(Im2);

Im3 = imread('Im3.jpg');
Im3 = im2double(Im3);

Im4 = imread('Im4.png');
Im4 = im2double(Im4);

subplot(2,2,1);
gimshow(Im1);
title('Image 1 - Gamma Corrected');

subplot(2,2,2);
gimshow(Im2);
title('Image 2 - Gamma Corrected');

subplot(2,2,3);
gimshow(Im3);
title('Image 3 - Gamma Corrected');

subplot(2,2,4);
gimshow(Im4);
title('Image 4 - Gamma Corrected');

pause;

close;

%% exe 3 Gray World
    
function processedImage = grayWorld(image)  
%%%% 3.1

rIm = image(:,:,1);
gIm = image(:,:,2);
bIm = image(:,:,3);

aR = computeMean(rIm);
aG = computeMean(gIm);
aB = computeMean(bIm);

%%%% 3.2

a = (aR+aG+aB)/3;

%%%% 3.3

processedImage(:,:)     = rIm*a/aR;
processedImage(:,:,2)   = gIm*a/aG;
processedImage(:,:,3)   = bIm*a/aB;

end

%%%% 3.4

grayWorld1 = grayWorld(Im1); 
grayWorld2 = grayWorld(Im2);

subplot(2,2,1);
imshow(Im1);
title('Image 1');

subplot(2,2,2);
gimshow(grayWorld1);
title('Image 1 - Gray World');

subplot(2,2,3);
imshow(Im2);
title('Image 2');

subplot(2,2,4);
gimshow(grayWorld2);
title('Image 2 - Gray World');

pause;
close;

%%%% 3.5
% As given, the Gray World algorithm assumes that the average reflectance spectrum of all objects in an image is flat.
% That assumption is obviously not always true. And hence averagine the
% intensity in all color channels would result in a misrepresentation of
% the original scene.


%% exe 4 Weighted Grey World
 
%%%% 4.1

rIm2 = Im2(:,:,1);
gIm2 = Im2(:,:,2);
bIm2 = Im2(:,:,3);

subplot(3,1,1); 
imhist(rIm2, 255); 
title('Red channel histogram');

subplot(3,1,2); 
imhist(gIm2, 255);
title('Green channel histogram');


subplot(3,1,3); 
imhist(bIm2, 255); 
title('Blue channel histogram');

pause;
close;

%%%% 4.2

% The imhist function gives us the bin repartition of the given image

function processedImage = weightedGrayWorld(image)

rIm = image(:,:,1);
gIm = image(:,:,2);
bIm = image(:,:,3);
    
[rDistribution, rBins] = imhist(rIm, 255);
[gDistribution, gBins] = imhist(gIm, 255);
[bDistribution, bBins] = imhist(bIm, 255);

% As hinted, we use the sign function to find out what pixels are used

rCount = sign(rDistribution);
gCount = sign(gDistribution);
bCount = sign(bDistribution);

rTotal = sum(rCount);
bTotal = sum(bCount);
gTotal = sum(gCount);

rAverage = (rCount.'*rBins)/rTotal;
gAverage = (gCount.'*gBins)/bTotal;
bAverage = (bCount.'*bBins)/gTotal;

%%%% 4.3

ImAverage = (rAverage + gAverage + bAverage)/3;

processedImage(:,:)     = (rIm*ImAverage)/rAverage;
processedImage(:,:,2)   = (gIm*ImAverage)/gAverage;
processedImage(:,:,3)   = (bIm*ImAverage)/bAverage;

end

subplot(2,1,1);
gimshow(grayWorld(Im2));
title('Image 2 - Gray World algorithm');

subplot(2,1,2);
gimshow(weightedGrayWorld(Im2));
title('Image 2 - Weighted Gray World algorithm');

pause;
close;

%%%% 4.4
% As you saw, the Gray World algorithm has some limitations, especially if
% we have an image with a predominant color. With the weighted gray world
% algorithm, we give each patch equal weight, independent of its size. That
% gives us a better balancing, especially in cases where there is a
% predominant color that would biais the Gray world algorithm.

%% exe 5 MaxRGB

function processedImage = MaxRGB (image)
  
%%%% 5.1

S           = sum(image, 3);
[~, idx]    = max(S(:));
[x, y]      = ind2sub(size(S), idx);

%%%% 5.2

point   = image(x, y, :);
gIm     = image(:, :, 2);
bIm     = image(:, :, 3);
 
rgRatio = point(1) / point(2);
rbRatio = point(1) / point(3);
 
processedImage          = image;
processedImage(:, :, 2) = gIm * rgRatio;
processedImage(:, :, 3) = bIm * rbRatio;

end

%%%% 5.3
 
subplot(3,2,1);
imshow(Im1);
title('Image 1 - Original');

subplot(3,2,2);
gimshow(MaxRGB(Im1));
title('Image 1 - MaxRGB');
 
subplot(3,2,3);
imshow(Im2);
title('Image 1 - Original');

subplot(3,2,4);
gimshow(MaxRGB(Im2));
title('Image 2 - MaxRGB');
 
subplot(3,2,5);
imshow(Im3);
title('Image 3 - Original');

subplot(3,2,6);
gimshow(MaxRGB(Im3));
title('Image 3 - MaxRGB');
 
pause;
close;

%%%% 5.4

function point = getUserPoint(image)
   gimshow(image);
   [x, y] = ginput(1);
   point = image(uint32(x), uint32(y), :);
end
 
function processedImage = MaxRGB2(image)
    point   = getUserPoint(image);

    gIm     = image(:, :, 2);
    bIm     = image(:, :, 3);
 
    rgRatio = point(1) / point(2);
    rbRatio = point(1) / point(3);
 
    processedImage          = image;
    processedImage(:, :, 2) = gIm * rgRatio;
    processedImage(:, :, 3) = bIm * rbRatio;
end
 
maxIm1 = MaxRGB2(Im1);
gimshow(maxIm1);
pause;

maxIm2 = MaxRGB2(Im2);
gimshow(maxIm2);
pause;

maxIm3 = MaxRGB2(Im3);
gimshow(maxIm3);
pause;

% The performance of this algorithm is faster at the computational level
% given the fact that the first part that consisted of finding the
% brightest point is no more needed.

%%%% 5.5

n = [3, 3];
preprocessedImage(:, :)    = medfilt2(Im3(:, :, 1), n);
preprocessedImage(:, :, 2) = medfilt2(Im3(:, :, 2), n);
preprocessedImage(:, :, 3) = medfilt2(Im3(:, :, 3), n);
 
subplot(1,2,1);
imshow(Im3);
title('Image 3');

subplot(1,2,2);
gimshow(MaxRGB(preprocessedImage));
title('Image 3 - Median filter and MaxRGB');
pause;
close;

%%%% 5.6
% What?s the advantage of above mentioned pre-processing step (median filtering)?

% The pre-processing step seems to remove a lot of the noise in the
% picture. The reduction of noise also allows MaxRGB find a proper scaling
% thanks to the removal of the brightest pixels.

%%%% 5.7
% When does it give good results?

% If the image is not too contrasted the result should be well balanced.

%%%% 5.8
% What are its limitations?

% As we've seen in the image with noise, the algorithm doesn't perceive the
% brightest pixel correctly (mistaken noise for image pixels). If there's a
% very bright spot on the picture, it's likely to not work properly.


%% exe 6 White Balance based on Illuminant Estimation


%%%% 6.1

%%%% 6.2

%%%% 6.3



%%%% 6.4

gimhow(grayWorld(Im4))

%%%% 6.5

% The limitation is that you need to know the illuminant spectrum and
% camera sensitivities. That's a lot of information that's required for an
% image.


end
