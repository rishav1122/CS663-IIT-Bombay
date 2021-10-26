Image = imread('barbara256.png');
[H,W] = size(Image);
%imshow(Image) %Uncomment to show original image
%Zero Padding to double the size
Zero_image= padarray(Image,[H/2 W/2],0);
Fourier_image = fftshift(fft2(Zero_image));
%Creating Array with center value 0 and creating its meshgrid
u = (-H+1):H;
v = (-W+1):W;
[U,V] = meshgrid(u,v);
%D value set it 40 or 80
D = 80;
%Sigma value set it 40 or 80
sigma=40;
log_fourier_image = log(abs(Fourier_image)+1); 
%Uncomment to show Fourier representation of Image
%imshow(log_fourier_image,[min(log_fourier_image(:)) max(log_fourier_image(:))]); colormap('jet'); colorbar;
%Ideal low pass filter
Ideal_low_pass_filter = double(U.^2+V.^2 <= D^2);
%Gaussian filter
Gaussian_low_pass_filter = exp(-(U.^2+V.^2)/(2*sigma^2));
%Uncomment to see frequency representation of Ideal low pass filter
%imshow(Ideal_low_pass_filter,[min(Ideal_low_pass_filter(:)) max(Ideal_low_pass_filter(:))]); colormap('jet'); colorbar;
%Uncomment to see frequency representation of Gaussian Filter
%imshow(Gaussian_low_pass_filter,[min(Gaussian_low_pass_filter(:)) max(Gaussian_low_pass_filter(:))]); colormap('jet'); colorbar;
%Uncomment the next line to apply Ideal low pass Filter
%Final_image_fourier = Fourier_image.*Ideal_low_pass_filter;
%Comment below line to aplly Ideal low pass filter
Final_image_fourier = Fourier_image.*Gaussian_low_pass_filter;
log_final_image = log(abs(Final_image_fourier));
%Uncomment to see fourier representation of transformed image
%imshow(log_final_image,[min(log_final_image(:)) max(log_final_image(:))]); colormap('jet'); colorbar;
Final_image_zero = real(ifft2(ifftshift(Final_image_fourier)));
%Extracting central HxW part
Final_image = Final_image_zero(H/2+1:3*H/2,W/2+1:3*W/2);
imshow(Final_image/max(Final_image(:)));


