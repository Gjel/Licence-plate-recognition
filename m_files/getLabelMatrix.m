% a function which binarizes the image and returns the label matrix and the
% boundaries of connected regions
function [B,L] = getLabelMatrix(frame)
    frame = stretch(frame);
    frame = imsharpen(frame, 'Radius', 2, 'Amount', 2);

    thres = graythresh(frame);
    frame = imbinarize(frame, (0.3 + thres)/2);
    
    frame = bwareaopen(frame, 512);
    
    [B,L] = bwboundaries(frame);
end