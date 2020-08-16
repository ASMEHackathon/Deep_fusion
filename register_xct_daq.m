%% so mapping btwn XCT pixel and DAQ coordinates is
x_pxl = 198;
y_pxl = 190;
% X axis are same direction
x_act = X_daq_0 + (x_pxl - X_xct_0)*(X_daq_N - X_daq_0)/(X_xct_N - X_xct_0);
% Y axis is opposite
dy_from_top = y_pxl - Y_xct_0;
dy = Y_xct_N - Y_xct_0 - dy_from_top;
y_act = Y_daq_0 + dy*(Y_daq_N - Y_daq_0)/(Y_xct_N - Y_xct_0);
% TODO better way? least squares fit? resolution?
% issue: resolutions don't match
fprintf("(%d,%d) pxl = (%f,%f) mm\n",x_pxl,y_pxl,x_act,y_act);
%% map XCT image number to layer number
z_res = 0.011953; % mm/pxl
layer_height = 20e-3; % in mm
xct_im_id = 28:31;
xc_im_z = z_res*xct_im_id;
layers = [floor(xc_im_z(1)/layer_height),ceil(xc_im_z(end)/layer_height)];
for i = xct_im_id
    xct = imread(sprintf('OverhangPartX4_Part1_2 Cropped%.4d.tif',i));
    figure;
    imshow(imbinarize(xct));
    xlim([X_xct_0 X_xct_N])
    ylim([Y_xct_0 Y_xct_N])
    axis equal
end
%%
% so layers are 16,17,18
for L = layers
    [~,XY_act] = align_xy_daq(L);
    %figure
    %scatter(XY_act.X,XY_act.Y);
    %hold on
    ind = proximalMeltPools(XY_act,x_act,y_act);
    %plot(XY_act.X(ind),XY_act.Y(ind),'rx','MarkerSize',8); 
    %xlim([X_daq_0 X_daq_N])
    %ylim([Y_daq_0 Y_daq_N])
    for j = ind
        mp = imread(meltPoolFileName(L,j));
    end
end
%% errors
MmPerPxl = 0.011953;
%MmPerPxl = 0.012;
xct_h_pxl = Y_xct_N - Y_xct_0;
xct_w_pxl = X_xct_N - X_xct_0;
xct_w_mm = MmPerPxl*xct_w_pxl;
xct_h_mm = MmPerPxl*xct_h_pxl;
daq_w_mm = X_daq_N - X_daq_0;
daq_h_mm = Y_daq_N - Y_daq_0;
e_y = daq_h_mm - xct_h_mm;
e_x = daq_w_mm - xct_w_mm;
%%
clc
fprintf('Dimensional stats from bounding box:\n');
fprintf('XCT size: %f by %f mm\n', xct_h_mm, xct_w_mm);
fprintf('DAQ size: %f by %f mm\n', daq_h_mm, daq_w_mm);
fprintf('error: %f by %f mm\n', xct_h_mm - daq_h_mm, xct_w_mm - daq_w_mm);
%%
