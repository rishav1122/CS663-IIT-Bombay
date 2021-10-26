J1 = imread("barbara256.png");
imshow(J1)
J1noise = imnoise(J1,'gaussian',0,(5/255)*(5/255));
imshow(J1noise)
J1noise = im2double(J1noise);
%% 
% 

I1 =mymeanshiftfilter(J1noise,2,2);
imwrite(I1,"1.png")
I2 =mymeanshiftfilter(J1noise,0.1,0.1);
imwrite(I2,"2.png")
I3 =mymeanshiftfilter(J1noise,3,15);
imwrite(I3,"3.png")
%% 
% 

J1 = imread("barbara256.png");
imshow(J1)
J1noise = imnoise(J1,'gaussian',0,(10/255)*(10/255));
imshow(J1noise)
J1noise = im2double(J1noise);
%% 
% 

I1 =mymeanshiftfilter(J1noise,2,2);
imwrite(I1,"1I.png")
I2 =mymeanshiftfilter(J1noise,0.1,0.1);
imwrite(I2,"2I.png")
I3 =mymeanshiftfilter(J1noise,3,15);
imwrite(I3,"3I.png")
%% 
% 

J1 = imread("kodak24.png");
imshow(J1)
J1noise = imnoise(J1,'gaussian',0,(5/255)*(5/255));
imshow(J1noise)
J1noise = im2double(J1noise);
%% 
% 

I1 =mymeanshiftfilter(J1noise,2,2);
imwrite(I1,"1J.png")
I2 =mymeanshiftfilter(J1noise,0.1,0.1);
imwrite(I2,"2J.png")
I3 =mymeanshiftfilter(J1noise,3,15);
imwrite(I3,"3J.png")
%% 
% 

J1 = imread("kodak24.png");
imshow(J1)
J1noise = imnoise(J1,'gaussian',0,(10/255)*(10/255));
imshow(J1noise)
J1noise = im2double(J1noise);
%% 
% 

I1 =mymeanshiftfilter(J1noise,2,2);
imwrite(I1,"1K.png")
I2 =mymeanshiftfilter(J1noise,0.1,0.1);
imwrite(I2,"2K.png")
I3 =mymeanshiftfilter(J1noise,3,15);
imwrite(I3,"3K.png")
%% 
%