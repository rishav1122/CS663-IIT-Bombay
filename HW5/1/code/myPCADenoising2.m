function denoised_img=myPCADenoising2(im1,patch,n_size,sigma,k)
    %% looping over every patch
    denoised_img = zeros(size(im1));
    [s_x,s_y] = size(im1);
    offset = floor(n_size/2);
      
    for r = 1:s_x-patch(1)+1
        for c = 1:s_y-patch(2)+1
            q_ref = im1(r:r+patch(1)-1,c:c+patch(2)-1);
%             size(q_ref)
            neighbourhood = im1(max(r-offset(1),1):min(s_x,r+offset(1)), ...
                                      max(r-offset(2),1):min(s_y,r+offset(2)));
%             size(neighbourhood)
            neighbor_col = im2col(neighbourhood,patch,'sliding');
%             size(neighbor_col)
            [idx,~] = knnsearch(neighbor_col',q_ref(:)','K',min(k,size(neighbor_col,2)));
            X = neighbor_col(:,idx);
            %% extracting eigenvectors of X*X'
            [V,~] = eig(X*X');
            eigen_coeff_vec = V'*X;

            %% estimating average eigen-coeff of original patch
            avg_sqr_coeff = max(0,mean(eigen_coeff_vec.^2,2) - sigma^2); 

            denominator = 1 + ((sigma^2)./avg_sqr_coeff);
            eigen_coeff_vec_P = V'*q_ref(:);
            denoised_eigen_coeff_vec_P = eigen_coeff_vec_P./denominator;
            
            denoised_P_col = V*denoised_eigen_coeff_vec_P;
            denoised_P = reshape(denoised_P_col,patch);
            denoised_img(r:r+patch(1)-1,c:c+patch(2)-1) = denoised_img(r:r+patch(1)-1,c:c+patch(2)-1) + denoised_P;
        end
    end    
    % calculating denominator for each pixel
    num_patches = size(im1) - patch + 1;
    denom_row_temp = ones(1,num_patches(2).*patch(2));
    denom_col_temp = ones(num_patches(1).*patch(1),1);
    denom_row = zeros(1,s_y);
    denom_col = zeros(s_x,1);

    for i=1:num_patches(2)
        denom_row(1,i:i+patch(2)-1) = denom_row(1,i:i+patch(2)-1) + denom_row_temp(1,(i-1)*patch(2)+1:i*patch(2));
    end
    for i=1:num_patches(1)
        denom_col(i:i+patch(1)-1,1) = denom_col(i:i+patch(1)-1,1) + denom_col_temp((i-1)*patch(1)+1:i*patch(1),:);
    end

    denom = denom_col*denom_row;
    denoised_img = denoised_img./denom;
    
end