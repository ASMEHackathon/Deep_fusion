%% 

% clear all; close all; clc
clear all
clc

%%
a = 31;
testfiledir = sprintf('MPM/Layer001to050/L00%d',a);
matfiles = dir(fullfile(testfiledir, '*.bmp'));
nfiles = length(matfiles);

%%
arr = zeros(nfiles,80,80);

for i=1:nfiles
    temp = imread(fullfile(testfiledir, matfiles(i).name));
    gt = rgb2gray(temp);
  
    arr(i,:,:) = gt(21:100,21:100); % crop images
end


%% 
ch = [];

for i=1:nfiles
   cont = imbinarize(reshape(arr(i,:,:),[80,80]),20);
   ch = [ch sum(sum(cont))];
end


%%

hist = [];

for i=1:nfiles
%    imagesc(reshape(arr(i,:,:),[80,80]));
%    title(num2str(mean(mean(arr(i,:,:)))))
    hist = [hist mean(mean(arr(i,:,:)))];
%    pause(0.005)
end

%%


layer_num = a; 

[~,pos_daq] = align_xy_daq(layer_num); %not using nominal

in_pos = [-3.6046,15.0210]; %input position



[d, index] = mink(dist(table2array(pos_daq(:,1:2)), in_pos'),5);

image_index = index % index of image


%% pixel2pos
x_pxl = 169;
y_pxl = 309;


x_act = X_daq_0 + (x_pxl - X_xct_0)*(X_daq_N - X_daq_0)/(X_xct_N - X_xct_0)
% Y axis is opposite
dy_from_top = y_pxl - Y_xct_0;
dy = Y_xct_N - Y_xct_0 - dy_from_top;
y_act = Y_daq_0 + dy*(Y_daq_N - Y_daq_0)/(Y_xct_N - Y_xct_0)