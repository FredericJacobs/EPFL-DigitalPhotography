function frederic_jacobs_exe4()
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

function normalizedDataset = normalizeDataset(dataset)
normalizedDataset = dataset / max(max(max(dataset)));
end

function nShow(image)
    nM = normalizeDataset(image);
    imshow(nM);
end

%% denoising
% 1.1

% We apply a gaussian filter

sigma = 1 ;
hsize = 5 * sigma;

subplot(1,2,1);nShow(im1);title('Original image');
subplot(1,2,2);nShow(denoise(im1, hsize, sigma));title(strcat('Denoised image with hsize = ',num2str(hsize), ' and sigma = ', num2str(sigma)));

pause;
close all;

% 1.2

% From the documentation: 
% h = fspecial('gaussian', hsize, sigma) returns a rotationally symmetric    
% Gaussian lowpass filter of size hsize with standard deviation sigma (positive). 
% hsize can be a vector specifying the number of rows and columns in h, or it can be a scalar, in which case h is a square matrix. 
% The default value for hsize is [3 3]; the default value for sigma is 0.5.

% The first parameter, hsize, is the size of the sliding window
% we want to process.

% The second parameter, sigma, is the standard deviation factor of the
% gaussian function.

subplot(3,3,1);nShow(denoise(im1, [3 3], 0.5));title('Denoised hsize = 3, sigma = 0.5');
subplot(3,3,2);nShow(denoise(im1, [3 3], 1));title('Denoised hsize = 3, sigma = 0.5');
subplot(3,3,3);nShow(denoise(im1, [3 3], 10));title('Denoised hsize = 3, sigma = 0.5');
subplot(3,3,4);nShow(denoise(im1, [6 6], 0.5));title('Denoised hsize = 6, sigma = 0.5');
subplot(3,3,5);nShow(denoise(im1, [6 6], 1));title('Denoised hsize = 6, sigma = 1');
subplot(3,3,6);nShow(denoise(im1, [6 6], 10));title('Denoised hsize = 6, sigma = 10');
subplot(3,3,7);nShow(denoise(im1, [12 12], 0.5));title('Denoised hsize = 12, sigma = 0.5');
subplot(3,3,8);nShow(denoise(im1, [12 12], 1));title('Denoised hsize = 12, sigma = 1');
subplot(3,3,9);nShow(denoise(im1, [12 12], 10));title('Denoised hsize = 12, sigma = 10');


% We notice that the larger the hsize is and the larger the sigma factor is
% the more the image gets blurred (but the less we notice the noise).

pause;
close all;

% 1.3
subplot(2,1,1);nShow(denoise(im1, hsize, sigma));title('Spacial denoise');
subplot(2,1,2);nShow(freqDenoise1(im1, [m n], sigma));title('Frequency denoise');

% Now that we're filtering the frequency domain, the Gaussian filter will
% attenuate frequencies that are further away from the image's "center"
% depending on the standard deviation factor.

pause;
close all;

%1.4

% We notice that the image is split in 4. This is due to the application of
% the gaussian filter on the frequency domain, indeed, the Gaussian
% transformation does require larger dimensions to be applied. 
 
subplot(1,2,1);nShow(im1);title('Gaussian Blur');
 
subplot(1,2,2);nShow(freqDenoise2(im1, sigma));title('Frequency denoised - wider range');

pause;
close;

%1.5

% We can't apply a median filter on a frequency domain because it's not
% linearly equivalent to applying it on the spatial domain (which is the
% case for the gaussian filter.

% There is a direct equivalenceny between a linear filter in the spatial
% domain and a linear filter in the frequency domain, which allows us to
% apply a linear filter in either of the domain.
% On the other hand, median filter is a non-linear filter, which does not
% have a direct equivalency between the two domain, and we can thus not
% apply it as-is in the frequency domain.

%% demosaicing
% 2.1

luminance = imfilter(im2,  fspecial('gaussian', [15,15] , 3));
chrominance = im2 - luminance;

nShow(chrominance);title('Chrominance');

pause;
close all;

% 2.2

% We could convert to the YCbCr color space to get the chrominance sampled
% out in the Cr component. 

% 2.3

demoChrominance = demosaic(chrominance);

nShow(demoChrominance);

pause;title('Demosaiced chrominance');
close all;

% 2.4

demoChrominance=demoChrominance(1:height, 1:width, :);

final(:,:,1)=demoChrominance(:,:,1)+luminance;
final(:,:,2)=demoChrominance(:,:,2)+luminance;
final(:,:,3)=demoChrominance(:,:,3)+luminance;

nShow(final);title('Result');

pause;
close all;


%% tone mapping
% 3.1

% 3.2

% 3.3

% 3.4

% 3.5

% 3.6

% 3.7


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

% The denoise function uses a gaussian distribution to remove noise.
function denoised = denoise(img, hsize, sigma)
h = fspecial('gaussian', hsize, sigma);
denoised = imfilter(img, h);
end

function denoised = freqDenoise1(img, hsize, sigma)
h = fspecial('gaussian', hsize, sigma);
im1freq = fft2(img) .* fft2(h);
denoised = ifft2(im1freq);
end

function denoised = freqDenoise2(img, sigma)
[m, n] = size(img);
h = fspecial('gaussian', [m,n] , sigma);
im1freq = fft2(img, m*2, n*2) .* fft2(h, m*2, n*2);
im1largedenoised = ifft2(im1freq);
denoised = im1largedenoised(m/2:m+m/2, n/2:n+n/2);
end

% ------------------------

function color  = demosaic(img)
[m ,n] = size(img);

% To make a color image, we compose a matrix per color. The composition is
% done by taking the image and removing the pixels that don't belong to
% that layer.

r = img;
r(2:2:m,:)=0;
r(:,2:2:n)=0;

b = img;
b(1:2:m,:)=0;
b(:,1:2:n)=0;


% A 2x2 source image has 2 green pixels, we male two different arrays that
% we'll merge.

g1 = img;

g1(2:2:m,:)=0;
g1(:,1:2:n)=0;

g2 = img;
g2(1:2:m,:)=0;
g2(:,2:2:n)=0;

g = g1 + g2;

FilterRB = [1,2,1;2,4,2;1,2,1]/4;
FilterG = [0,1,0;1,4,1;0,1,0]/4;

color(:,:,1)=conv2(r,FilterRB);
color(:,:,3)=conv2(b,FilterRB);
color(:,:,2)=conv2(g,FilterG);

end




