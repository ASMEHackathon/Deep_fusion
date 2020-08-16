%% 
clear all; close all; clc

%%

layer_num = 29; 

[~,pos_daq] = align_xy_daq(layer_num); %not using nominal

%% Give input position and get index of image with closest value based on daq position

in_pos = [-4.0933,12.5336]; %input position



[d, index] = mink(dist(table2array(pos_daq(:,1:2)), in_pos'),5);

image_index = index % index of image