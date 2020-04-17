function res = stretch(frame)
    minval = min(frame(:));
    maxval = max(frame(:));
    res = (frame - minval) * (255/(maxval - minval));
end 