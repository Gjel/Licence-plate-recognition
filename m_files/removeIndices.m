function res = removeIndices(remove, BBs)
    res = BBs;
    for i = 1:1:length(remove)
        res(:,remove(i) - i + 1) = [];
    end
end 