% Frederic Jacobs

% I rushed this homework being confused with the deadline being sooner than
% I thought and thinking it was not graded (introduction slides). 

function ex2_frederic_jacobs()

clc
clear all
close all

load exe2;

plotRange = linspace(400, 700, 31);

%% Answer to Question 1

%%% 1.1 
% We want to plot 3 illuminants on the same plot where the axis X
% represents the Wavelength and the Y axis the relative power.

figure
plotDataset = [normalizeDataset(D65), normalizeDataset(A), normalizeDataset(F2)];
plot(plotRange ,plotDataset);
title('1.1 : Graph of D65, A and F2 illuminants');
xlabel('Wavelength [nm]');
ylabel('Relative Spectral Power');
legend('D65', 'A','F2');
pause;

%%% 1.2 Drawing reflectance

% We extract the two samples needed (130,160) and (290,320)

vector1 = S(:,130,160);
vector2 = S(:,290,320);

plotDataset = [normalizeDataset(vector1), normalizeDataset(vector2)];
plot(plotRange ,plotDataset);
title('1.2: Graph of respective reflectance spectra');
xlabel('Wavelength [nm]');
ylabel('Reflectance factor');
legend('Reflectance of (130, 160)', 'Reflectance of (290, 320)');

pause;


%%% 1.3

plotDataset = [computeCameraSensitivity(10), computeCameraSensitivity(100)];
plot(plotRange, plotDataset);
title('1.3: Graph of camera sensitivities');
xlabel('Wavelength [nm]');
ylabel('Camera sensitivity');
annotation('textbox',...
    [0.510714285714284 0.611904761904762 0.317857142857141 0.0833333333333339],...
    'String',{'Smooth curves are the result of high sensitivity (sigma = 100)'},...
    'FitBoxToText','off');
annotation('textbox',...
    [0.301 0.428571428571429 0.356142857142857 0.102380952380961],...
    'String',{'Angular curves are the result of the use of a less sensitivity (signma = 10)'},...
    'FitBoxToText','off');

% What effects will the different sensistivity functions have on the
% final image?

% We notice that a more sensitive function results on a smoother curve.
% Similarly, the final image will have additional details.

pause;

close all;

%% Answer to Question 2

clear all
close all

load exe2;

% 2.1 Image under illuminant D65 using sigma = 10

S1          = reshape(S, 31, 512 * 512);
sigma10     = reshape(computeCameraSensitivity(10), 31, 3);
sigma100    = reshape(computeCameraSensitivity(100), 31, 3);

figure
subplot(3,2,1)
C1 = composeImage(D65, S1, sigma10);
imshow(C1), title('D65, Sigma 10')
subplot(3,2,2)

% 2.2 Image under illuminant D65 using sigma = 100

C2 = composeImage(D65, S1, sigma100);
imshow(C2), title('D65, Sigma 100')
subplot(3,2,3)

% 2.3 Image under illuminant A using sigma = 10

C3 = composeImage(A, S1, sigma10);
imshow(C3), title('A, Sigma 10')
subplot(3,2,4)

% 2.4 Image under illuminant A using sigma = 100

C4 = composeImage(A, S1, sigma100);
imshow(C4), title('A, Sigma 100')
subplot(3,2,5)

% 2.5 Image under illuminant F2 using sigma = 10

C5 = composeImage(F2, S1, sigma10);
imshow(C5), title('f2, Sigma 10')
subplot(3,2,6)

% 2.6 Image under illuminant F2 using sigma = 100

C6 = composeImage(F2, S1, sigma100);
imshow(C6), title('F2, Sigma 100')

end

% function to normalize a dataset
function normalizedDataset = normalizeDataset(dataset)
normalizedDataset = bsxfun(@rdivide,dataset,max(dataset));
end

function C = composeImage(E, S, R)
    C = S' * diag(E) * R;
    C = normalizeDataset(C);
    C = reshape(C, 512, 512, 3);
end

% function for computing the camera sensitivities
function R = computeCameraSensitivity(sigma)

red     = exp(- ((400:10:700) - 650).^2/(2 * sigma^2));

green   = exp(- ((400:10:700) - 550).^2/(2 * sigma^2));

blue    = exp(- ((400:10:700) - 450).^2/(2 * sigma^2));

R = [red' green' blue'];

R = R/max(R(:));
end