function res = cutOuts(frame, BBs)
    [~,N] = size(BBs);
    res = cell(1,N);
    for i = 1:1:N
        BB = BBs(:,i);
        res{i} = frame(BB(2):BB(4), BB(1):BB(3));
    end
end