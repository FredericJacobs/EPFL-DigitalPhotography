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

%%%% 3.2

%%%% 3.3

%%%% 3.4

%%%% 3.5
% write your answer here

%% exe 4 Weighted Grey World

%%%% 4.1

%%%% 4.2

%%%% 4.3

%%%% 4.4
% write your answer here

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
