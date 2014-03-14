function exe2_template()

clc
clear all
close all

load exe2;


%% Answer to Question 1


%% Answer to Question 2


%% Answer to Question 3


%% Answer to Question 4


%% Answer to Question 5


%% Answer to Question 6


end


% function for computing the camera sensitivities
function R = computeCameraSensitivity(sigma)

red     = exp(- ((400:10:700) - 650).^2/(2 * sigma^2));

green   = exp(- ((400:10:700) - 550).^2/(2 * sigma^2));

blue    = exp(- ((400:10:700) - 450).^2/(2 * sigma^2));

R = [red' green' blue'];

R = R/max(R(:));
end