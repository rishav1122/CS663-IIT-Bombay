%% MyMainScript
close all
clear all
clc

im = double(imread('barbara256.png'));

%%  adding gaussian noise
sigma = 20;
im1_gaussian = im+randn(size(im)).*sigma;

%% Part (A)
tic;
im2_a = myPCADenoising1(im1_gaussian,[7 7],sigma);
rmse = norm((im2_a-im),'fro')/norm(im,'fro');
disp('RMSE A:');
disp(rmse);
figure;
imshowpair(im1_gaussian/255, im2_a/255, 'montage');



%% Part (B)
im = double(imread('stream.png'));
im = im([1:256],[1:256]);

sigma = 20;
im1_gaussian = im+randn(size(im)).*sigma;


im2_b = myPCADenoising2(im1_gaussian,[7 7], [31,31], sigma, 200);
rmse = norm((im2_b-im),'fro')/norm(im,'fro');
disp('RMSE B:');
disp(rmse);
figure;
imshowpair(im1_gaussian/255, im2_b/255, 'montage');
title('Noisy image and Denoised Image using 200 most similar patches', 'Fontsize', 12, 'Fontname', 'Cambria');


im = double(imread('stream.png'));
im = im([1:256],[1:256]);

sigma = 20;
im1_gaussian = im+randn(size(im)).*sigma;


im2_b = myPCADenoising2(im1_gaussian,[7 7], [31,31], sigma, 200);
rmse = norm((im2_b-im),'fro')/norm(im,'fro');
disp('RMSE stream B:');
disp(rmse);
figure;
imshowpair(im1_gaussian/255, im2_b/255, 'montage');
title('Noisy image and Denoised Image using 200 most similar patches', 'Fontsize', 12, 'Fontname', 'Cambria');



%% Part (C)
im2_c = myBilateralFiltering(im1_gaussian,7, 1, 0.4);
rmse = norm((im2_c-im),'fro')/norm(im,'fro');
disp('RMSE using Bilateral Filtering is:');
disp(rmse);
figure;
imshowpair(im1_gaussian/255, im2_c/255, 'montage');
title('Noisy image and Denoised Image (Part C)', 'Fontsize', 12, 'Fontname', 'Cambria'); 

