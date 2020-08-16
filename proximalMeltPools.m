function indx = proximalMeltPools(XY,x,y)
tol = 50e-3; % 50 um
v = 1:height(XY);
ind = abs(XY.X - x) < tol & abs(XY.Y - y) < tol;
indx = v(ind);
end

