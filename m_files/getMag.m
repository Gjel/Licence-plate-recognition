% a function which returns the sum of the magnitudes per direction of the gradient  
function res = getMag(discretized, gMag, bins)
    res = zeros(bins,1);
    [X,Y] = size(discretized);

    for i = 1:1:X
        for j = 1:1:Y
            idx = discretized(i,j);
            res(idx) = res(idx) + gMag(i,j);
        end
    end
end