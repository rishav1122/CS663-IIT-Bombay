
%im1=imread('LC2.jpg');
im1=imread('LC1.png');
imshow(im1);

n=7;

im2 = padarray(im1,[(n-1)/2 (n-1)/2],0,'both');
im3= im1;

for r = 1:size(im3, 1)    % for number of rows of the image
    for c = 1:size(im3, 2)  
        z=zeros(1,256);
        suma=0;
        for j = -(n-1)/2:(n-1)/2
           for i= -(n-1)/2:(n-1)/2
                z(im2(r+j+(n-1)/2,c+i+(n-1)/2)+1)= z(im2(r+j+(n-1)/2,c+i+(n-1)/2)+1) + 1;
           end
        end
        
        for k= 1:(im2(r+(n-1)/2,c+(n-1)/2)+1)
           suma= suma+ z(k);           
        end
        
        im3(r,c)= round((suma/(n*n))*255);
        % increment counter loop
    end
    
end

%imshow(im3);
J = histeq(im1);
imshow(J)








