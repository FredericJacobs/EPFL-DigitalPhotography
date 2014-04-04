% Frederic Jacobs

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

% Can you already determine the effect of the different illuminants
% on the final image?

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

% TO-DO: What colors do these reflectances represent?

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

% TO-DO: What effects will the different sensistivity functions have on the
% final image?

% We notice that a more sensitive function results on a smoother curve.
% Similarly, the final image will have additional details.

pause;

close all;

%% Answer to Question 2


%% Answer to Question 3


%% Answer to Question 4


%% Answer to Question 5


%% Answer to Question 6


end

% function to normalize a dataset
function normalizedDataset = normalizeDataset(dataset)
normalizedDataset = bsxfun(@rdivide,dataset,max(dataset));
end

% function for computing the camera sensitivities
function R = computeCameraSensitivity(sigma)

red     = exp(- ((400:10:700) - 650).^2/(2 * sigma^2));

green   = exp(- ((400:10:700) - 550).^2/(2 * sigma^2));

blue    = exp(- ((400:10:700) - 450).^2/(2 * sigma^2));

R = [red' green' blue'];

R = R/max(R(:));
end