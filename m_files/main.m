% DO NOT TOUCH, IT WORKS
function res = main()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHANGE THIS TO RUN YOUR TEST FILES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    reader = VideoReader('data\TrainingVideo.avi');
    solutionPath = 'data\TrainingSolutionsFixed.mat';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    video = figure('Name','Licence Plate Recognition','NumberTitle','off');
    plates = figure('Name','Potential Hit','NumberTitle','off');
    data = figure('Name','Licence Plate Data','NumberTitle','off');
    load('data\template_combined.mat');

    figure(plates)
    plate = imshow(uint8(zeros(480,640)));

    figure(video)
    image = imshow(zeros(480,640));
    framenumber = 1;
    datacount = 1;
    uit = uitable(data);

    pause(2);
    results = cell(1,3);
    bins = 8;
    while hasFrame(reader)
        colorframe = readFrame(reader);
        if mod(framenumber,8) == 0
            grayframe = rgb2gray(colorframe);
            [B,~] = getLabelMatrix(grayframe);
            BBs = getBB(B);

            [~,N] = size(BBs);
            cuts = cutOuts(grayframe, BBs);
            for i = 1:1:N
                cuts{i} = rotatePlate(cuts{i});
                [charBBs,~] = getCharBBs(cuts{i});
                charBBs = filterBBs(charBBs);
                if isPlate(cuts{i},charBBs)
                    plateBBs = overlayBB(cuts{i},charBBs);
                    set(plate,'CData',plateBBs);
                    str = readPlate(cuts{i},charBBs,template,transform, bins * 2);
                    [valid, processed] = post(str, results, datacount);
                    if valid
                        uit.Data{datacount,1} = processed;
                        results{datacount, 1} = processed;
                        uit.Data{datacount,2} = framenumber;
                        results{datacount, 2} = framenumber;
                        uit.Data{datacount,3} = reader.CurrentTime;
                        results{datacount, 3} = reader.CurrentTime;
                        datacount = datacount + 1;
                    end
                    drawnow;
                end
                drawnow;
            end

            %Display original in grayscale, with overlayed boundingboxes
            frameBB = overlayBB(grayframe, BBs);
            set(image,'CData', frameBB);

        end
        framenumber = framenumber + 1;
    end
    checkSolution(results,solutionPath)
end