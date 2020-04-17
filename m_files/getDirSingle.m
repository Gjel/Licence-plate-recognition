% a function which returns the bins/2 value descriptor of a cut out of a
% character
function res = getDirSingle(char, bins)

char = imgaussfilt(char,1);
[M,N] = size(char);
halfY = floor(M/2);
halfX = floor(N/2);

% divide the char in four (roughly) equal parts
quad1 = char(1:halfY, 1:halfX);
quad2 = char(halfY:M, 1:halfX);
quad3 = char(1:halfY, halfX:N);
quad4 = char(halfY:M, halfX:N);
quads = {quad1,quad2,quad3,quad4};

% bin the direction of the gradient and add up the magnitudes per quarant
tMag = 0;
for s = 1:4
    [gMag, gDir] = imgradient(quads{s});
    tMag = tMag + sum(sum(gMag));
    lin = linspace(-180, 180, bins + 1);
    [Y,~] = discretize(gDir, lin);
    out = getMag(Y,gMag, bins);
    out2 = out(3:2:bins-1,:) + out(2:2:bins-2,:);
    out2(bins/2) = out(1) + out(bins);
    quads{s} = out2;
end

res = vertcat(quads{:});
end