
function Imnew =mymeanshiftfilter(image,sds,sdr)    
    numf=21;
    n0 = 11;
    n1 = 10;
    
    [a,b] = size(image);
    new = zeros(a-numf,b-numf);
    
    for i = n0:a-n0
        for j = n0:b-n0
            i_new = i;
            j_new = j;
            d1 = i-n1:i+n1;
            d2=j-n1:j+n1;
            [X0,Y0] = meshgrid(d1,d2);
            tempx=i;
            tempy=j;
         
            count = 0;
            converge=false;
            I_new = image(i_new,j_new);
            while converge~=true
                X = X0-i_new;
                Y = Y0-j_new;
                Z= X.*X +Y.*Y;
                Ds = exp(-(Z)/(2*sds*sds))/(sds*sqrt(2*pi));
                some =image(i_new,j_new);
                I1 = image(i-n1:i+n1,j-n1:j+n1)-I_new;
                numI =  Ds.*gs1(I1,sdr).*image(i-n1:i+n1,j-n1:j+n1);
                numsumI = sum(sum(numI));
                den =  Ds.*gs1(I1,sdr);
                densum = sum(sum(den));
                I_new = numsumI/densum;
                
            
                numx = Ds.*gs1(I1,sdr).*X0;
                numsumx=sum(sum(numx));
                numy = Ds.*gs1(I1,sdr).*Y0;
                numsumy=sum(sum(numy));
                i_new = round(numsumx/densum);
                j_new = round(numsumy/densum);
                
                if i_new==tempx || count==50
                    if j_new ==tempy || count==50
                        converge=true;
%                         if count>10
%                             disp(count)
%                         end
%                         disp(i)
%                         disp(j)
%                         disp('i_new')
% %                         disp(i_new)
%                         disp('j_new')
%                         disp(j_new)
%                         disp('count')    
%                         disp(count)
                        break
                    end
                end
                tempx = i_new;
                tempy = j_new;
                count= count+1;
            end
            
            new(i-n0+1,j-n0+1) = I_new;
        end
    end
    imshow(new)
    Imnew = new;
end
function val = gs1(I1,sd)
    val = 1/(sd*sqrt(2*pi))*exp(-(I1.*I1)/(2*sd*sd));
end