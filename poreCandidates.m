function [Ls,indx] = poreCandidates(xct_n, x)
z_res = 0.011953; % mm/pxl
layer_height = 20e-3; % in mm
xct_im_id = xct_n;
xc_im_z = z_res*xct_im_id;
Ls = floor(xc_im_z(1)/layer_height):ceil(xc_im_z(end)/layer_height);
% for L = 1:length(Ls)
%     [~,XY] = align_xy_daq(L);
%     indx = img_index_finder(XY,x,1);
% end
indx = 2;
end

