function [res,dashed] = post(str, prevstr, idx)
    res = true;
    dashed = 'FU-CK-ED';

    if length(str) ~= 6
        res = false;
        return
    end

    order = isstrprop(str, 'alpha');
    dutch = {[1 1 0 0 1 1];[1 1 1 1 0 0];[1 1 0 0 0 0];[0 0 1 1 0 0];[0 0 0 0 1 1];[0 0 1 1 1 1];[1 1 0 0 0 1];[0 0 1 1 1 0];[1 0 0 0 1 1];[0 1 1 1 0 0]};
    contains = false;

    for i = 1:length(dutch)
        if isequal(order, dutch{i})
            contains = true;
            if i <= 6
                dashed = [str(1:2) '-' str(3:4) '-' str(5:6)];
            elseif i > 8
                dashed = [str(1) '-' str(2:4) '-' str(5:6)];
            else
                dashed = [str(1:2) '-' str(3:5) '-' str(6)];
            end
            break
        end
    end

    if ~contains
        res = false;
        return
    end
    
    for i = 1:idx - 1
        if strcmp(dashed,prevstr{i,1})
            res = false;
            return
        end
    end
end