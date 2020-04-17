function t = isodata(im)
    hist = imhist(im);
    gmin = min(im(:));
    gmax = max(im(:));
    t0 = (gmin + gmax) / 2;
    while true
        m1 = 0;
        m1d = 0;
        for i = gmin+1:t0
            m1 = m1 + double(i) * hist(i);
            m1d = m1d + hist(i);
        end
        m2 = 0;
        m2d = 0;
        for i = t0:gmax+1
            m2 = m2 + double(i) * hist(i);
            m2d = m2d + hist(i);
        end
        m1 = m1/m1d;
        m2 = m2/m2d;

        t1 = round(((m1 + m2) / 2), 0);

        if abs(t1 - double(t0)) > 0
            t0 = t1;
        else
            t = t0;
            break;
        end
    end
end