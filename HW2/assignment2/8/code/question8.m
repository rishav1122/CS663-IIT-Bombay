J1 = imread("barbara256.png");
imshow(J1)
J1noise = imnoise(J1,'gaussian',0,(5));
imshow(J1noise)
J1noise = im2double(J1noise);
%% 
% 

I1 =mybilateralfilter(J1noise,2,2);
imwrite(I1,"1.png")
I2 =mybilateralfilter(J1noise,0.1,0.1);
imwrite(I2,"2.png")
I3 =mybilateralfilter(J1noise,3,15);
imwrite(I3,"3.png")
%% 
% 
% 
% 

J2 = imread("kodak24.png");
imshow(J2)
J2noise = imnoise(J2,'gaussian',0,5/255*5/255);
imshow(J2noise)
J2noise = im2double(J2noise);
%% 
% 

I1 =mybilateralfilter(J2noise,2,2);
imwrite(I1,"1J.png")
I2 =mybilateralfilter(J2noise,0.1,0.1);
imwrite(I2,"2J.png")
I3 =mybilateralfilter(J2noise,3,15);
imwrite(I3,"3J.png")
%% 
% 

% numf=5;
% n0 = 3;
% n1 = 2
% sds = 2;
% d1 = 1:numf;
% [X,Y] = meshgrid(d1,d1);
% X = X-n0
% Y = Y-n0
% Z= X.*X +Y.*Y
% Ds = exp(-(Z)/(2*sds*sds))/(sds*sqrt(2*pi))
%% 
% 

% % [a,b] = size(J1)
% % image = J1noise;
% % numf=5;
% % n0 = 3;
% % n1 = 2;
% % sds = 2;
% % sdr = 2;
% % num=0;
% % den=0;
% % new = zeros(a-numf+1,b-numf+1);
% % for i = n0:a-n0
% %     for j = n0:b-n0
% %         num=0;
% %         den=0;
% %         for k =i-n1:i+n1
% %             for l = j-n1:j+n1
% %                 num = num+ Ds(k-i+n0,l-j+n0)*gs(image(i,j),image(k,l),sdr)*image(k,l);
% %                 den = den+ Ds(k-i+n0,l-j+n0)*gs(image(i,j),image(k,l),sdr);
% %             end
% %         end
% %         new(i-n0+1,j-n0+1) = num/den;
% %     end
% % end
% % imshow(new)
%% 
% 

% 
% 
% 
%% 
% 

% [a,b] = size(J1)
% image = J1noise;
% numf=5;
% n0 = 3;
% n1 = 2
% sds = 2;
% sdr = 2/255;
% num=0;
% den=0;
% new = zeros(a-numf,b-numf);
% for i = n0:a-n0
%     for j = n0:b-n0
%         I1 = image(i-n1,j+n1)-image(i,j);
%         num =  Ds.*gs1(I1,sdr).*image(i-n1,j+n1);
%         numsum = sum(sum(num));
%         den =  Ds.*gs1(I1,sdr);
%         densum = sum(sum(den));
%         new(i-n0+1,j-n0+1) = numsum/densum;
%     end
% end
% imshow(new)
%% 
% 
%% 
% 

% % function val = ds(x1,y1,x2,y2,sd)
% %     val = 1/(sd*sqrt(2*pi))*exp(-((x1-x2)*(x1-x2)-(y1-y2)*(y1-y2))/(2*sd*sd));
% % end
% % 
% % function val = gs(I1,I2,sd)
% %     val = 1/(sd*sqrt(2*pi))*exp(-((I1-I2)*(I1-I2))/(2*sd*sd));
% % end
% 
%%
% function val = gs1(I1,sd)
%     val = 1/(sd*sqrt(2*pi))*exp(-(I1.*I1)/(2*sd*sd));
% end