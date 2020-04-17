function [res,L] = getCharBBs(frame)
    % Get boundaries, the label matrix is actually not of use to us.
    [B,L] = getLabelMatrixLetters(frame);

    % Init of result
    % res is a 2D array. 
    % Rows are of size 4, containing the vertical and horizontal
    % min and max values.
    % Every column is a bounding box.
    res = [];
    resi = 0;

    % Main loop.
    % take the boundaries returned by matlab and converts them to boxes
    for k = 1:length(B)
        boundary = B{k};

        % All these values are coordinates in the image.
        % minima and maxima are used to draw the bounding box
        [xmax, ~] = max(boundary(:,2)); % maximum x value and index of that value
        [ymax, ~] = max(boundary(:,1)); % maximum y value and index of that value
        [xmin, ~] = min(boundary(:,2)); % minimum x value and index of that value
        [ymin, ~] = min(boundary(:,1)); % minimum y value and index of that value

        sizex = xmax - xmin; % width of our box; along the x axis
        sizey = ymax - ymin; % height of our box; along the y axis
        ratio = sizex / sizey; % ratio between the two.

        % Some preliminary filtering of the resulting boundingboxes.
        % We know that certain shapes and sizes cannot be correct,
        % so those boxes are ignored right away.
        if sizey > 9 && sizex > 1 && ratio < 0.9
            resi = resi + 1;
            res(:,resi) = [xmin;ymin;xmax;ymax];
        end
    end
end