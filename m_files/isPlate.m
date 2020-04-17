function res = isPlate(cut,charBBs)
    res = false;
    [~,N] = size(charBBs);
    if N>= 6 && N <= 10
        res = true;
    end
end