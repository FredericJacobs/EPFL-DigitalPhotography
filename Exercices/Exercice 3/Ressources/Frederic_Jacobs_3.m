function Frederic_Jacobs_3()
clc
close all
clear all

function nM = normalizeMatrix(dataset)
    nM = dataset/max(max(max(dataset)));
end

function nM = normalizeImage(image)
    nM        = normalizeMatrix(image(:,:,1));
    nM(:,:,2) = normalizeMatrix(image(:,:,2));
    nM(:,:,3) = normalizeMatrix(image(:,:,3));
end

function gCorrected = gCorrection(Im, gamma)
    Im = normalizeImage(Im);
    Im = power(Im(:,:,:), 1/gamma);
    gCorrected = normalizeImage(Im);
end


function meanvalue = computeMean(imageChannel)
    meanvalue = mean(mean(mean(imageChannel)));
end

%% Initialization
gamma = 2.4;
Im1 = imread('Im1.jpg');
Im1 = im2double(Im1);

Im2 = imread('Im2.jpg');
Im2 = im2double(Im2);

Im3 = imread('Im3.jpg');
Im3 = im2double(Im3);

Im4 = imread('Im4.png');
Im4 = im2double(Im4);

Im1gCorrected = gCorrection(Im1, gamma);
Im2gCorrected = gCorrection(Im2, gamma);
Im3gCorrected = gCorrection(Im3, gamma);
Im4gCorrected = gCorrection(Im4, gamma);

subplot(2,2,1);imshow(Im1gCorrected);title('Image 1 - Gamma Corrected');
subplot(2,2,2);imshow(Im2gCorrected);title('Image 2 - Gamma Corrected');
subplot(2,2,3);imshow(Im3gCorrected);title('Image 3 - Gamma Corrected');
subplot(2,2,4);imshow(Im4gCorrected);title('Image 4 - Gamma Corrected');pause;

close;

%% exe 3Grey World

%%%% 3.1

rIm1 = Im1gCorrected(:,:,1);
gIm1 = Im1gCorrected(:,:,2);
bIm1 = Im1gCorrected(:,:,3);

rIm2 = Im2gCorrected(:,:,1);
gIm2 = Im2gCorrected(:,:,2);
bIm2 = Im2gCorrected(:,:,3);

aR_Im1 = computeMean(rIm1);
aG_Im1 = computeMean(gIm1);
aB_Im1 = computeMean(bIm1);

aR_Im2 = computeMean(rIm2);
aG_Im2 = computeMean(gIm2);
aB_Im2 = computeMean(bIm2);

%%%% 3.2

a1 = (aR_Im1+aG_Im1+aB_Im1)/3;
a2 = (aR_Im2+aG_Im2+aB_Im2)/3;

%%%% 3.3

rescaledIm1(:,:)= rIm1*a1/aR_Im1;
rescaledIm1(:,:,2)= gIm1*a1/aG_Im1;
rescaledIm1(:,:,3)= bIm1*a1/aB_Im1;

rescaledIm2(:,:)= rIm2*a2/aR_Im2;
rescaledIm2(:,:,2)= gIm2*a2/aG_Im2;
rescaledIm2(:,:,3)= bIm2*a2/aB_Im2;

%%%% 3.4

subplot(2,2,1);imshow(Im1gCorrected);title('Image 1 - Gamma Corrected');
subplot(2,2,2);imshow(rescaledIm1);title('Image 1 - Gray World Corrected');
subplot(2,2,3);imshow(Im2gCorrected);title('Image 2 - Gamma Corrected');
subplot(2,2,4);imshow(rescaledIm2);title('Image 2 - Gray World Corrected');

pause;

%%%% 3.5
% As given, the Gray World algorithm assumes that the average reflectance spectrum of all objects in an image is flat.
% That assumption is obviously not always true. And hence averagine the
% intensity in all color channels would result in a misrepresentation of
% the original scene.


%% exe 4 Weighted Grey World

%%%% 4.1

subplot(3,1,1); 
imhist(rIm1, 255); 
title('histogram RED');

subplot(3,1,2); 
imhist(bIm1, 255);
title('histogram GREEN');


subplot(3,1,3); 
imhist(rIm1, 255); 
title('histogram BLUE');

pause;


%%%% 4.2

% The imhist function gives us the bin repartition of the given image

[rDistribution, rBins] = imhist(rIm2, 255);
[gDistribution, gBins] = imhist(gIm2, 255);
[bDistribution, bBins] = imhist(bIm2, 255);

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

Im2Average = (rAverage + gAverage + bAverage)/3;

Im2Resampled(:,:)     = (rIm2*Im2Average)/rAverage;
Im2Resampled(:,:,2)   = (gIm2*Im2Average)/gAverage;
Im2Resampled(:,:,3)   = (bIm2*Im2Average)/bAverage;

subplot(2,1,1);
imshow(rescaledIm2);
title('Image 2 - Grey World Algorithm');


subplot(2,1,2);
imshow(Im2Resampled);
title('Image 2 - Weighted Grey World algorithm');

pause;

%%%% 4.4
% As you saw, the Gray World algorithm has some limitations, especially if
% we have an image with a predominant color. With the weighted gray world
% algorithm, we give each patch equal weight, independent of its size. That
% gives us a better balancing, especially in cases where there is a
% predominant color that would biais the Gray world algorithm.

%% exe 5 MaxRGB
%%%% 5.1

%%%% 5.2

%%%% 5.3

%%%% 5.4

%%%% 5.5

%%%% 5.6, 5.7, and 5.8
% write your answer here

%% exe 6 White Balance based on Illuminant Estimation
%load exe3.mat

%%%% 6.1

%%%% 6.2

%%%% 6.3

%%%% 6.4

%%%% 6.5
% write your answer here



end
