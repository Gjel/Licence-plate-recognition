function res = filterBBs(BBs)
    res = BBs;

    %remove smaller BBs
    [~,N] = size(res);
    height = zeros(1,N);
    for i = 1:1:N
        height(i) = (res(4,i) - res(2,i));
    end
    [val,~] = max(height);
    remove = [];
    index = 0;
    for i = 1:1:N
        if height(i) < 0.75 * val
            index = index + 1;
            remove(index) = i;
        end
    end
    res = removeIndices(remove,res);

    % remove nested BBs
    remove = [];
    index = 0;
    [~,N] = size(res);
    for i = 1:1:N
        for j = 1:1:N
            if res(1,i) < res(1,j) && res(2,i) < res(2,j) && res(3,i) > res(3,j) && res(4,i) > res(4,j)
                index = index + 1;
                remove(index) = i;
            end
        end
    end
    remove = unique(remove.','rows').';
    res = removeIndices(remove,res);
end