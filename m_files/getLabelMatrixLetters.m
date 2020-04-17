% a function which binarizes the image and returns the label matrix and the
% boundaries of connected regions (for cut outs of plates)
function [B,L] = getLabelMatrixLetters(frame)
    frame = stretch(frame);
    frame = imsharpen(frame, 'Radius', 2, 'Amount', 2);
    
    thres1 = graythresh(frame);
    thres2 = isodata(frame)/255;
    thres = (thres1 + thres2)/2;
    frame = imbinarize(frame, (0.15 + thres)/2);
      
    [B,L] = bwboundaries(frame);
end