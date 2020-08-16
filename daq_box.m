%% read all layer scan XY one by one
% find boundary of the part
Xmin = Inf;
Xmax = -Inf;
Ymin = Inf;
Ymax = -Inf;
boxes = zeros(250,4);
for i = 1:250
    fprintf('(%f,%f,%f,%f),%d\n',Xmin,Ymin,Xmax,Ymax,i);
    D = dlmread(sprintf('DAQ_Part01_L%.4d.csv',i));
    X = D(:,1);
    Y = D(:,2);
    Xmin = min(X(:));
    Ymin = min(Y(:));
    Xmax = max(X(:));
    Ymax = max(Y(:));
    boxes(i,:) = [Xmin, Ymin, Xmax, Ymax];
end
%%
BB_Daq = array2table(boxes,'VariableNames',{'X_m','Y_m','X_M','Y_M'});
%%
figure
for i = 1:4
    subplot(1,4,i)
    %boxplot(XCT_Outline{:,i})
    boxplot(BB_Daq{:,i})
end
%%
X_daq_0 = median(BB_Daq.X_m)
Y_daq_0 = median(BB_Daq.Y_m)
X_daq_N = median(BB_Daq.X_M)
Y_daq_N = median(BB_Daq.Y_M)

