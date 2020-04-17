function [resD,resM,matchD,matchM,dist,mse] = matchChar(descriptor, template, transform)
    [~,N] = size(template);
    dist = zeros(1,N);
    mse = zeros(1,N);
    for i = 1:1:N
        dist(i) = sqrt(sum((descriptor - template(:,i)) .^ 2));
        mse(i) = immse(descriptor,template(:,i));
    end

    [~,index] = min(dist);
    resD = transform(index);
    matchD = template(:,index);
    [~,index] = min(mse);
    resM = transform(index);
    matchM = template(:,index);
end