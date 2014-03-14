clc
clear all
close all

%************
%load images
%************


name='mandrill.jpg';

%load image
im = imread(name); % uint8
imN= im2double(im);


% ! ATTENTION !
%
% imshow displays: 
% either: uint8 [0..255]
% or: double [0..1]

fprintf('*********************************************\n');
fprintf('                 DISPLAYING IMAGES\n');
fprintf('*********************************************\n');

%imshow
imshow(im); title('imshow(baboon)'); pause;

%************
% GRAY images
%************
fprintf('*********************************************\n');
fprintf('                 GRAY IMAGES\n');
fprintf('*********************************************\n');
fprintf('in progress...');
%
imgr = rgb2gray(im); %% gray image in uint8
imgrN = rgb2gray(imN); %% gray image in double

% plot of the grayscale image with varying levels of gray
% notice that the image used here is the uint8 image (why?)
imshow(imgr);title('original gray image');pause(2);
imshow(128*(imgr/128)); title('image with 2 levels of gray'); pause(2);
imshow(64*(imgr/64)); title('image with 4 levels of gray'); pause(2);
imshow(32*(imgr/32)); title('image with 8 levels of gray'); pause(2);
imshow(16*(imgr/16)); title('image with 16 levels of gray'); pause(2);
imshow(8*(imgr/8)); title('image with 32 levels of gray'); pause(2);
imshow(4*(imgr/4)); title('image with 64 levels of gray'); pause(2);
imshow(2*(imgr/2)); title('image with 128 levels of gray'); pause(2);

fprintf('done!\n press any key\n')
pause;
close;


%************
% RGB images
%************
fprintf('*********************************************\n');
fprintf('                 RGB IMAGES\n');
fprintf('********************************************\n');
fprintf('in progress...');

imR = imN(:,:,1);
imG = imN(:,:,2);
imB = imN(:,:,3);
im_R = zeros(size(im)); im_R(:,:,1) = imR;
im_G = zeros(size(im)); im_G(:,:,2) = imG;
im_B = zeros(size(im)); im_B(:,:,3) = imB;

subplot(1,2,1);
imshow([imR ;imG ;imB]);
title('RGB channels in gray scale');
subplot(1,2,2);
imshow([im_R ;im_G ;im_B]);
title('RGB channels in true colors');
fprintf('done!\n press any key\n')
pause;
close;

%************
% BRIGHTNESS
%************
fprintf('*********************************************\n');
fprintf('                 BRIGHTNESS\n');
fprintf('*********************************************\n');
fprintf('in progress...');

%gray images
pippo=imgrN;
subplot(3,3,1);imshow(pippo-0.5);title('original-0.5');
subplot(3,3,2);imshow(pippo-0.3);title('original-0.3');
subplot(3,3,3);imshow(pippo-0.1);title('original-0.1');
subplot(3,3,4);imshow(pippo-0.05);title('original-0.05');
subplot(3,3,5);imshow(pippo);title('original');
subplot(3,3,6);imshow(pippo+0.05);title('original+0.05');
subplot(3,3,7);imshow(pippo+0.1);title('original+0.1');
subplot(3,3,8);imshow(pippo+0.3);title('original+0.3');
subplot(3,3,9);imshow(pippo+0.5);title('original+0.5');
fprintf('done!\npress any key\n');pause;
close;
fprintf('wait a few seconds\n');


%color images
pippo=imN;
% a1=10; a2=25; a3=50;
% dima=4; dimb=3;

subplot(4,3,2); imshow(pippo);title('original');
%
ff=4;

% add to the red channel
tmp = pippo; tmp(:,:,1) = tmp(:,:,1) + 0.05;
subplot(4,3,4);imshow(tmp);
title('RED + 0.05');
%
tmp = pippo; tmp(:,:,1) = tmp(:,:,1) + 0.1;
subplot(4,3,5);imshow(tmp);
title('RED + 0.1');
%
tmp = pippo; tmp(:,:,1) = tmp(:,:,1) + 0.2;
subplot(4,3,6);imshow(tmp);
title('RED + 0.2');

% add to the green channel
tmp = pippo; tmp(:,:,2) = tmp(:,:,2) + 0.05;
subplot(4,3,7);imshow(tmp);
title('GREEN + 0.05');
%
tmp = pippo; tmp(:,:,2) = tmp(:,:,2) + 0.1;
subplot(4,3,8);imshow(tmp);
title('GREEN + 0.1');
%
tmp=pippo; tmp(:,:,2) = tmp(:,:,2) + 0.2;
subplot(4,3,9);imshow(tmp);
title('GREEN + 0.2');

% add to the blue channel
tmp = pippo; tmp(:,:,3) = tmp(:,:,3) + 0.05;
subplot(4,3,10); imshow(tmp);
title('BLUE + 0.05');
%
tmp = pippo; tmp(:,:,3) = tmp(:,:,3) + 0.1;
subplot(4,3,11); imshow(tmp);
title('BLUE + 0.1');
%
tmp = pippo; tmp(:,:,3) = tmp(:,:,3) + 0.2;
subplot(4,3,12); imshow(tmp);
title('BLUE + 0.2');

fprintf('done!\n press any key\n');
pause;
close;


%************
% Histograms
%************
fprintf('*********************************************\n');
fprintf('                 HISTOGRAMS\n');
fprintf('*********************************************\n');
fprintf('in progress...');

subplot(2,3,1); imhist(imgrN); title('histogram original gray');
subplot(2,3,2); imhist(imgrN + 0.2); title('histogram original gray + 0.2');
subplot(2,3,4); imhist(imR); title('histogram RED');
subplot(2,3,5); imhist(imG); title('histogram GREEN');
subplot(2,3,6); imhist(imB); title('histogram BLUE');
fprintf('done!\n press any key\n ')
pause;
close;

fprintf('\n');
fprintf('*********************************************\n');
fprintf('                COLORMAPS \n');
fprintf('*********************************************\n');
fprintf('Get familiar with Matlab''s colormaps\n');
imageext;



