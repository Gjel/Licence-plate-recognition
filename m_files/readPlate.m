function res = readPlate(plate,BBs,template,transform, bins)
    cuts = cutOuts(plate,BBs);
    res = char(length(cuts));
    for i = 1:1:length(cuts)
       desc = getDirSingle(cuts{i}, bins);
       [res(i),~,~,~,~,~] = matchChar(desc,template,transform);
    end
end 