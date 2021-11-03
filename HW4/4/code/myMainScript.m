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


%EIGENVALUES
%[W,D] = eigs(transpose(train_image_array)*train_image_array,192);
%U = train_image_array*W;
%U = U./sum(U);

%TESTING
%for i= 1:length(K)
%    U_k = U(:,1:K(i));
%    rr =0;
%    projected_train_image_array = transpose(U_k)*train_image_array;
%    for j= 1:32
%        for k = 1:4
%            test_image = test_image_array(:,32*(k-1)+j)-mean_images;
%            projected_test_vector = transpose(U_k)*test_image(:);
%            distance = vecnorm(projected_train_image_array-projected_test_vector,2,1);
%            [M,I] = min(distance);
%            if mod(I-1,32)+1 == j
%               rr = rr+1; 
%            end
%        end
%    end
%   final_rr(i) = rr/(32*4);
%end

%plot(K,final_rr) 

%ORL FACE Reconstruction
%K_r = [2 10 20 50 75 100 125 150 175];
%h =[];
%for i=1:length(K_r)
%   U_k = U(:,1:K_r(i));
%   projected_image = transpose(U_k)*train_image_array(:,2);
%   recovered_image = U_k*projected_image;
%   subplot(3,3,i),imshow(reshape(recovered_image,112,[]),[])
%end

%25 Eigenfaces 
Eigenfaces = U(:,1:25);
for i = 1:25
   subplot(5,5,i),imshow(reshape(Eigenfaces(:,i),112,[]),[])
end
















% % INITIALIZATION
% 
% image_size = 192*168;
% train_image_array = zeros(image_size,38,40);
% test_image_array = zeros(image_size,38,24);
% K = [5 10 15 20 30 50 60 65 75 100 200 300 500 1000];
% final_rr = zeros([length(K),1]);
% 
% %FILE READING
% directory_name = dir('CroppedYale/');
% is_directory = [directory_name.isdir]  & ~strcmp({directory_name.name},'.') & ~strcmp({directory_name.name},'..');
% person_directory = directory_name(is_directory);
% 
% for i= 1:length(person_directory)
%     image_files = dir(['CroppedYale/' person_directory(i).name '/*.pgm']);
%     for j=1:length(image_files)
%         image = double(imread(['CroppedYale/' person_directory(i).name '/' image_files(j).name]));
%         if (j>40)
%             test_image_array(:,i,j-40) = image(:);
%         else
%             train_image_array(:,i,j) = image(:);
%         end
%     end
% end
% 
% train_image_array = reshape(train_image_array,image_size,[]);
% test_image_array = reshape(test_image_array,image_size,[]);
% 
% %MEAN
% mean_images = mean(train_image_array(:,:),'all');
% train_image_array= train_image_array-mean_images;
% 
% %SVD
% [U,S,V] = svd(train_image_array,"econ");
% 
% 
% %EIGENVALUES
% %[W,D] = eigs(transpose(train_image_array)*train_image_array,192);
% %U = train_image_array*W;
% %U = U./sum(U);
% 
% 
% %TESTING
% for i= 1:length(K)
%     U_k = U(:,4:K(i));
%     %U_k = U(:,1:K(i));
%     rr =0;
%     projected_train_image_array = transpose(U_k)*train_image_array;
%     for j= 1:38
%         for k = 1:24
%             test_image = test_image_array(:,38*(k-1)+j)-mean_images;
%             projected_test_vector = transpose(U_k)*test_image(:);
%             distance = vecnorm(projected_train_image_array-projected_test_vector,2,1);
%             [M,I] = min(distance);
%             if mod(I-1,38)+1 == j
%                rr = rr+1; 
%             end
%         end
%     end
%    final_rr(i) = rr/(38*24);
% end
% 
% 
% plot(K,final_rr)
