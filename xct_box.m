%% bounding box for all images
boxes = zeros(440,4);
for i = 400
    xct = imread(sprintf('OverhangPartX4_Part1_2 Cropped%.4d.tif',i));
    xct = imbinarize(xct);
    imagesc(xct)
    hold on
    props = regionprops(bwconncomp(xct),'BoundingBox'); 
    rectangle('Position',props(1).BoundingBox);
    %boxes(i,:) = props(1).BoundingBox;
    fprintf('%d done\n',i)
    %pause(0.01)
end
%%
XCT_Outline = array2table(boxes,'VariableNames',{'X','Y','W','H'});
XCT_Outline{:,5} = XCT_Outline{:,1} + XCT_Outline{:,3};
XCT_Outline{:,6} = XCT_Outline{:,2} + XCT_Outline{:,4};
XCT_Outline.Properties.VariableNames{5} = 'X_r';
XCT_Outline.Properties.VariableNames{6} = 'Y_r';
XCT_Outline{:,7} = (1:440)';
XCT_Outline.Properties.VariableNames{7} = 'ImageNumber';
%%
subplot(1,2,1)
plot(XCT_Outline.W,'LineWidth',1)
ylim([700 800])
subplot(1,2,2)
plot(XCT_Outline.H,'LineWidth',1)
ylim([400 450])
%%
PixelPerMm = 83.6610;
reasonableShift = 0.1;
reasonableXY = reasonableShift*PixelPerMm;
ind1 = XCT_Outline.W < 700 | XCT_Outline.W == 770;
ind2 = XCT_Outline.H < 400 | XCT_Outline.H == 440; % too small or whole image
ind = XCT_Outline.X <= reasonableXY | XCT_Outline.Y <= reasonableXY;
ind  = ind | XCT_Outline.W < 700;
ind = ind | XCT_Outline.H < 400;
fprintf('total outliers: %d\n',sum(ind))
fprintf('outliers by widht AND length: %d\n',sum(ind1 & ind2));
fprintf('outliers by widht OR length: %d\n',sum(ind1 | ind2));
% so they overlap almost exactly
BB_XCT = XCT_Outline(~ind,:);
%%
binSz = floor(sqrt(height(BB_XCT)));
subplot(1,2,1)
histogram(BB_XCT.W,binSz);
subplot(1,2,2)
histogram(BB_XCT.H,binSz);
%%
figure
for i = 1:4
    subplot(1,4,i)
    %boxplot(XCT_Outline{:,i})
    boxplot(BB_XCT{:,i})
end
%%
X_xct_0 = median(BB_XCT.X)
Y_xct_0 = median(BB_XCT.Y)
X_xct_N = median(BB_XCT.X_r)
Y_xct_N = median(BB_XCT.Y_r)

