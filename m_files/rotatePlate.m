function res = rotatePlate(frame)
    bwframe = stretch(frame);
    bwframe = imsharpen(bwframe, 'Radius', 2, 'Amount', 2);

    thres = graythresh(bwframe);
    bwframe = imbinarize(bwframe, (0.3 + thres)/2);

    bwframe = bwareaopen(bwframe, 512);
    [B, ~] = bwlabel(bwframe, 8);
    blobmes = regionprops(B, 'Orientation');
    or = [blobmes.Orientation];

    if ~isempty(or) && abs(or(1)) > 5 
        mainor = or(1);
        res = imrotate(frame, -mainor);
    else
        res = frame;
    end
end