% INITIALIZATION

image_size = 112*92;
train_image_array = zeros(image_size,32,6);
test_image_array = zeros(image_size,32,4);
not_in_gallery_image_array = zeros(image_size,8,4);
K = [1 2 3 5 10 15 20 30 50 75 100 150 170];
final_rr = zeros([length(K),1]);

%FILE READING
directory_name = dir('ORL/');
is_directory = [directory_name.isdir]  & ~strcmp({directory_name.name},'.') & ~strcmp({directory_name.name},'..');
person_directory = directory_name(is_directory);

for i= 1:length(person_directory)
    image_files = dir(['ORL/' person_directory(i).name '/*.pgm']);
    for j=1:length(image_files)
        image = double(imread(['ORL/' person_directory(i).name '/' image_files(j).name]));
        if (i > 32) && (j<=4)
            not_in_gallery_image_array(:,i-32,j) = image(:);
        elseif (i <= 32) && (j>6)
            test_image_array(:,i,j-6) = image(:);
        elseif (i <= 32) && (j<=6)
            train_image_array(:,i,j) = image(:);
        end
    end
end

train_image_array = reshape(train_image_array,image_size,[]);
test_image_array = reshape(test_image_array,image_size,[]);
not_in_gallery_image_array = reshape(not_in_gallery_image_array,image_size,[]);
%imshow(reshape(train_image_array(:,1),112,92),[])
 
%MEAN
mean_images = mean(train_image_array(:,:),'all');
train_image_array= train_image_array-mean_images;

%SVD
[U,S,V] = svd(train_image_array);




%TESTING
thres= zeros(32*3);

U_k = U(:,1:50);
rr =0;
projected_train_image_array = transpose(U_k)*train_image_array;
for j= 1:32
   for k = 1:4
       test_image = test_image_array(:,32*(k-1)+j)-mean_images;
       projected_test_vector = transpose(U_k)*test_image(:);
       distance = vecnorm(projected_train_image_array-projected_test_vector,2,1);
       [M,I] = min(distance);
       if mod(I-1,32)+1 == j
          thres((j-1)*3 + k)= M; 
       end
   end
end

   







num=0;
val=0;
max=0;
for i=1:length(thres)
    if thres(i)>0
        num=num+1;
        val=val+thres(i);
        if thres(i)>max
            max= thres(i);
        end
    end
end

meann= val*1.0/num;
threshold= meann + 0.55*(max- meann);












k1=0;
k2=0;
projected_train_image_array = transpose(U_k)*train_image_array;
for j= 1:32
    for k=1:4
       test_image = test_image_array(:,32*(k-1)+ j)-mean_images;
       projected_test_vector = transpose(U_k)*test_image(:);
       distance = vecnorm(projected_train_image_array-projected_test_vector,2,1);
       [M,I] = min(distance);
       k1= k1+1;
       if M>threshold
           k2= k2+1;
       end
    end
end

falsenegative= k2*1.0/k1;












k3=0;
k4=0;
projected_train_image_array = transpose(U_k)*train_image_array;

for j= 1:8
   for k = 1:4
       test_image = not_in_gallery_image_array(:,8*(k-1)+j)-mean_images;
       projected_test_vector = transpose(U_k)*test_image(:);
       distance = vecnorm(projected_train_image_array-projected_test_vector,2,1);
       [M,I] = min(distance);
       k3= k3+1;
       if M<threshold
           k4= k4+1;
       end
   end
end

falsepositive= k4*1.0/k3;





