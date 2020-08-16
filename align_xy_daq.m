function [XY_nom,XY_act] = align_xy_daq(layerNumber)
    i = layerNumber;
    D_nom = dlmread(sprintf('XYPT_Part01_L%.4d.csv',i));
    D_act = dlmread(sprintf('DAQ_Part01_L%.4d.csv',i));
    D_nom = array2table(D_nom,'VariableNames',{'X','Y','P','Trigger'});
    D_act = array2table(D_act,'VariableNames',{'X','Y','LTZ','P'});
    % histogram(D_act_tbl.P,100)
    % use threshold to separate actual commands from near-zeros of "true power"
    thr = 5;
    % find first laser firing instance
    start_nom = find(D_nom.P > thr,1);
    start_act = find(D_act.P > thr,1);
    ind_delta = start_nom - start_act;
    % measurements are always shifted back
    %assert(ind_delta > 0);
    % find the last triggered image & drop everything after
    ind_last_nom = find(D_nom.Trigger > 0,1,'last');
    D_nom = D_nom(ind_delta:ind_last_nom,:);
    L = size(D_nom,1); % final size
    % should have at least as many measurements
    assert(size(D_act,1) >= L);
    % align the data
    D_act = D_act(1:L,:);
    %assert(size(D_act,1) == size(D_nom,1))
    % finally, drop all entries without triggered images
    ind = D_nom.Trigger > 0;
    XY_act = D_act(ind,[1,2,4]); % ignore LTZ
    XY_nom = D_nom(ind,1:3);
end
