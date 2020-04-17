function res = overlayBB(frame, BBs)
    [M,N,O] = size(frame);
    res = uint8(zeros(M,N,3));
    if islogical(frame)
        for m = 1:1:M
            for n = 1:1:N
                if frame(m,n) == 1
                   res(m,n,:) = 255; 
                end
            end
        end
    elseif O == 1
        for i = 1:1:3
            res(:,:,i) = frame;
        end
    else
        res = frame;
    end
    [~,N] = size(BBs);
    RGB = [255,0,0];
    for i = 1:1:N
        hor = uint8(zeros(1,BBs(3,i)-BBs(1,i)+1,3));
        vert = uint8(zeros(BBs(4,i)-BBs(2,i)+1,1,3));
        for c = 1:1:3
           hor(:,:,c) = RGB(c);
           vert(:,:,c) = RGB(c);
        end
        res(BBs(2,i), BBs(1,i):BBs(3,i), :) = hor;
        res(BBs(4,i), BBs(1,i):BBs(3,i), :) = hor;
        res(BBs(2,i):BBs(4,i), BBs(1,i), :) = vert;
        res(BBs(2,i):BBs(4,i), BBs(3,i), :) = vert;
    end
end