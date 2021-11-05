
 function filtered_img = myBilateralFiltering(img, window, sigma_space, sigma_intensity)
    % img to be in  'double' format
    % window to be a positive odd integer
    
    filtered_img = double(zeros(size(img,1), size(img,2)));
    % disp(filtered_img);
    % Get weights for spatial Gaussian
    [x,y] = meshgrid(-floor(window/2): floor(window/2), -floor(window/2): floor(window/2));
    G_s = exp(-(x.^2 + y.^2)/(2 * sigma_space^2));
    
    wait = waitbar(0, "Bilateral Filter in Progress");
    
    % Pass over the image
    for i = 1:size(img,1)
        % disp(i);
        % max & min used to account for edge pixels
        i_min = max(i - floor(window/2), 1);    
        i_max = min(i + floor(window/2), size(img,1));
        
        for j = 1:size(img,2)

            % max & min used to account for edge pixels
            j_min = max(j - floor(window/2), 1);
            j_max = min(j + floor(window/2), size(img,2));
            
            curr_intensity = img(i,j);
            intensity_window = img(i_min:i_max, j_min:j_max);
            
            % get weights for intensity gaussian
            G_i = exp(-(intensity_window - curr_intensity).^2 / (2 * sigma_intensity^2));
            
            overall_weights = G_s((i_min:i_max) - i + floor(window/2) + 1, (j_min:j_max) - j + floor(window/2) + 1) .* G_i;
            filtered_img(i,j) = sum(sum(overall_weights .* intensity_window)) / sum(sum(overall_weights));     
            
        end
        waitbar(i/double(size(img,1)));
    end
    close(wait);
end