function Imnew = mybilateralfilter(image,sds,sdr)
    numf=9;
    n0 = 5;
    n1 = 4;
    
    d1 = 1:numf;
    [X,Y] = meshgrid(d1,d1);
    X = X-n0;
    Y = Y-n0;
    Z= X.*X +Y.*Y;
    Ds = exp(-(Z)/(2*sds*sds))/(sds*sqrt(2*pi));
    
    
  
    [a,b] = size(image);
    new = zeros(a-numf,b-numf);
    for i = n0:a-n0
        for j = n0:b-n0
            I1 = image(i-n1:i+n1,j-n1:j+n1)-image(i,j);
            num =  Ds.*gs1(I1,sdr).*image(i-n1:i+n1,j-n1:j+n1);
            numsum = sum(sum(num));
            den =  Ds.*gs1(I1,sdr);
            densum = sum(sum(den));
            new(i-n0+1,j-n0+1) = numsum/densum;
        end
    end
    imshow(new)
    Imnew = new;
end

function val = gs1(I1,sd)
    val = 1/(sd*sqrt(2*pi))*exp(-(I1.*I1)/(2*sd*sd));
end