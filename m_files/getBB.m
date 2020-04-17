function res = getBB(B)
    res = [];
    resi = 0;
    for k = 1:length(B)
            
        boundary = B{k};

        % All these values are coordinates in the image. minima and
        % maxima are used to draw the bounding box
        [xmax, xmaxi] = max(boundary(:,2)); % maximum x value and index of that value
        [ymax, ymaxi] = max(boundary(:,1)); % maximum y value and index of that value
        [xmin, xmini] = min(boundary(:,2)); % minimum x value and index of that value
        [ymin, ymini] = min(boundary(:,1)); % minimum y value and index of that value
        xmaxy = boundary(xmaxi, 1); % x value corresponding to the maximum y value
        ymaxx = boundary(ymaxi, 2); % y value corresponding to the maximum x value
        xminy = boundary(xmini, 1); % x value corresponding to the maximum y value
        yminx = boundary(ymini, 2); % y value corresponding to the maximum x value

        sizex = xmax - xmin; % width of our box; along the x axis
        sizey = ymax - ymin; % height of our box; along the y axis
        ratio = sizex / sizey; % ratio between the two.
        
        if ratio > 4 && ratio < 6 && sizex > 100 && sizey > 15
            resi = resi + 1;
            res(:,resi) = [xmin;ymin;xmax;ymax];
        elseif ratio > 1 && ratio < 5 && sizex > 70
            margin = 1/16 * pi;
            % compare the angle of the two main diagonals 
            if yminx > ymaxx
                theta1 = atan((xmaxy - ymin)/(xmax - yminx));
                theta2 = atan((ymax - xminy)/(ymaxx - xmin));
                if theta1 > theta2 - margin && theta1 < theta2 + margin
                    resi = resi + 1;
                    res(:,resi) = [xmin;ymin;xmax;ymax];
                end
            else
                theta1 = atan((xminy - ymin)/(yminx - xmin));
                theta2 = atan((ymax - xmaxy)/(xmax - ymaxx));
                if theta1 > theta2 - margin && theta1 < theta2 + margin
                    resi = resi + 1;
                    res(:,resi) = [xmin;ymin;xmax;ymax];
                end
            end
        end
    end
end