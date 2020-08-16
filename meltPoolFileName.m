function str = meltPoolFileName(L,n)
chunk = floor((L-1)/50);
bottom = chunk*50 + 1;
top = (chunk+1)*50;
str = sprintf('MPM/Layer%.3dto%.3d/L%.4d/frame_%.4d.bmp',bottom,top,L,n);
end

