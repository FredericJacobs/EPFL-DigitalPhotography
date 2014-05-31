function exe4_template_2014()
clc
close all
clear all

load 'exe4.mat'

% convert 1st image to double precision
im1 = im2double(im1);
% image size
[m,n] = size(im1);

% convert 2nd image to double precision
im2 = im2double(im2);
% image size
[height,width,channel] = size(im2);

%% denoising
% 1.1

% 1.2

% 1.3

%1.4

%1.5

%% demosaicing
% 2.1

% 2.2

% 2.3

% 2.4

% 2.5

% 2.6

%% tone mapping
% 4.1

% 4.2

% 4.3

% 4.4

% 4.5

end

function img_out = post_processing(img_in)

% do a histogram stretching of the luminance channel in the YCbCr space
In = rgb2ycbcr(img_in);
Y = In(:,:,1);

% find low and high values
low_high = stretchlim(Y, [0 1]);
newMax = low_high(2);
newMin = low_high(1);

% do correction
Y = imadjust(Y,[newMin; newMax],[16/255; 235/255],2.4); % see matlab help to know why 16/255 and 235/255
In(:,:,1) = Y;
img_out = ycbcr2rgb(In);

end
