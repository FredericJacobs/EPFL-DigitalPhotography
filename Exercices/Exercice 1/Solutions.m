<pre><div class="text_to_html">close all, clear all
clc

% DIGITAL PHOTOGRAPHY
% Solution Exercise 1
% 

% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% Part 1: Matrix multiplication and applying linear transform to images
% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*

% 1.1 Load the file "exercice1.mat", which contains six 3x3 matrices and the
% the file "vega.jpg" and convert it into double format
load('exercise1.mat')
I0 = im2double(imread('vega.jpg'));

% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 1.2 Apply each matrix to the image 
% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 1.3 display the original and six resulting images on one figure using 
% the command subplot and add titles.

[m,n,l] = size(I0);

I1 = reshape(I0, n*m,3);

figure, 
subplot(3,3,2), imshow(I0), title('original')
subplot(3,3,4), imshow(reshape((A1*I1')', m, n, l)), title('sets red and blue channels to zero')
subplot(3,3,5), imshow(reshape((A2*I1')', m, n, l)), title('divides by 2')
subplot(3,3,6), imshow(reshape((A3*I1')', m, n, l)), title('converts to gray')
subplot(3,3,7), imshow(reshape((A4*I1')', m, n, l)), title('desaturates')
subplot(3,3,8), imshow(reshape((A5*I1')', m, n, l)), title('increases contrast')
subplot(3,3,9), imshow(reshape((A6*I1')', m, n, l)), title('inverts colors')

pause, close(1)
clear I0 I1 I2

% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% Part 2: Manipulating images
% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 2.1. load images lavaux.jpg and polylan.jpg
% get the gray-scale version of both images
I1 = imread('polylan.jpg');
I2 = imread('lavaux.jpg');
 
I1_gray = rgb2gray(I1);
I2_gray = rgb2gray(I2);


% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 2.2.  display the images using the functions "imshow"
figure, 
subplot(1,2,1), imshow(I1)
title('imshow'), title('color image')
subplot(1,2,2), imshow(I1_gray)
title('imshow'), title('gray image')
pause, close(1)

% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 2.3. determine (using matlab coding) which one of the two
%    images is brighter.

Bright1 = mean(mean(mean(I1))) % =  84.42
Bright2 = mean(mean(mean(I2))) % = 140.62

% lavaux.jpg is brighter
% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 2.4.  change (using an automated form) both gray images so 
% that they have approximately the same average brightness. 
% Display them. Any comments?

figure
subplot(2,2,1),imshow(I1)
title('Original Image 1')
subplot(2,2,2),imshow((128/Bright1)*I1)
title('average brightness = 128')
subplot(2,2,3),imshow(I2)
title('Original Image 2')
subplot(2,2,4), imshow((128/Bright2)*I2)
title('average brightness = 128')

pause, close(1)
% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
[lin1, col1, x] = size(I1);
[lin2, col2, x] = size(I2);

% as both images don't have the same size, you can either
% resize them (using the function imresize) or make the final image have
% the same size as the smallest image. 

% 2.5. merge 2 images and display:
%    top half of one image, bottom half of the other 

lin = min(lin1, lin2);
col = min(col1, col2);  

I5( 1:lin/2, 1:col, :) = I1(1:lin/2, 1:col, :);
I5(lin/2 + 1:lin, 1:col, :) = I2(lin/2 + 1:lin, 1:col, :);

figure, imshow(I5)
title('merge the 2 images: 2 halves')

pause, close(1)

% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 2.6.  interleave all the lines
I6(1:2:lin, 1:col, :) = I1(1:2:lin, 1:col, :);
I6(2:2:lin, 1:col, :) = I2(2:2:lin, 1:col, :);

figure, imshow(I6)
title('merge the 2 images: interleave lines')

pause, close(1)
% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 2.7.  interleave all the columns

I7(1:lin, 1:2:col, :) = I1(1:lin, 1:2:col, :);
I7(1:lin, 2:2:col, :) = I2(1:lin, 2:2:col, :);

figure, imshow(I7)
title('merge the 2 images: interleave columns')

pause, close(1)
% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 2.8.  interleave lines of width 15 pixels 

I8(1:lin, 1:col, :) = I1(1:lin, 1:col, :);
for l = 0: floor(col/30)
    I8(1:lin, 30*l + 1: 30*l + 15, :) = I2(1:lin, 30*l + 1 : 30*l + 15, :);
end

figure, imshow(I8)

pause, close(1)

% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 2.9. add the images
I9 = I1(1:lin, 1:col, :) + I2(1:lin, 1:col, :);

figure, imshow(I9)
title('add the images')

pause, close(1)
% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 2.10. add the images and normalize
I10 = double(I1(1:lin, 1:col, :)) + double(I2(1:lin, 1:col, :));
I10 = uint8(255*I10/max(I10(:)));

figure, imshow(I10);
title('add the images ansd normalize')

pause, close(1)
% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 2.11. average the images
I11 = (I1(1:lin, 1:col, :) + I2(1:lin, 1:col, :))/2;

figure, imshow(I11);
title('average the images')

pause, close(1)
% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 2.12. Formats and saving option

% load image "bc.bmp"
I12 = imread('bc.bmp');
figure, imshow(I12)
% save the image in the TIFF format. What are the saving options?
imwrite(I12, 'bc.tif')

% TIFF options are Colorspace, Compression factor, Description (attach 
% a string to the image), Resolution and Writemode.

% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 2.13. save the image in the JPEG format, with a quality factor of 25%. 
% Load back the image. What differences do you see?

imwrite(I12, 'bc.jpg', 'jpg', 'Quality', 25)

I13 = imread('bc.jpg');

subplot(2,1,1), imshow(I12), title('Original BMP image')
subplot(2,1,2), imshow(I13),title('JPG: Quality factor 25%')

pause, close all

% we see more compression artifacts in the center of the
% image. 

% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% Part 3: Finding and replacing values in an image
% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*

J1 = imread('I_noise1.tif');
J2 = imread('I_noise2.tif');

[m, n, l] = size(J1);

% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 3.1 Using the command find, retrieve the indices corresponding to the
% pixels of the image having the values 0 and 255

ind0 = find(J1 == 0);
ind255 = find(J1 == 255);

% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 3.2 Replace these pixels by the value 127
J1_mod1 = J1;
J1_mod1(ind0) = 127;
J1_mod1(ind255) = 127;

% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 3.3 Use image ?I_noise2.tif? to replace the noisy pixels in image ?I_noise1.tif?
J1_mod2 = J1;
J1_mod2(ind0) = J2(ind0);
J1_mod2(ind255) = J2(ind255);

figure
subplot(2,2,1), imshow(J1), title('noisy image 1')
subplot(2,2,2), imshow(J2), title('noisy image 2')
subplot(2,2,3), imshow(J1_mod1), title('salt and pepper pixels set to 127')
subplot(2,2,4), imshow(J1_mod2), title('salt and pepper pixels taken from image 2')

pause, close
% =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
% 4.1 load image "bc.tif" and convert it to a double format gray scale image

K1 = rgb2gray(im2double(imread('bc.tif')));

% 4.2 the file exercise1.mat also contains two 3x3 filters F1 and F2
% use the function imfilter to filter this image using F1
% what effect does this filter have?
K2 = imfilter(K1, F1);
figure
imshow(K2)
title('image filtered by F1')
% F1 blurs the image.



% 4.3 use the function imfilter to filter this image using F2 and with its
% transpose
% what effect does this filter have?
K3 = imfilter(K1, F2);
K4 = imfilter(K1, F2');
figure
subplot(2,1,1), imshow(K3)
title('image filtered by F2')
subplot(2,1,2), imshow(K4)
title('image filtered by the transpose of F2')
% F2 computes the vertical, and its transpose computes the horizontal edges.  
pause, close all
</div></pre>