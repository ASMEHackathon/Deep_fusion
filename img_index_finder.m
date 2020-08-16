function indx = img_index_finder(daq_table,coordinate,numElem)
    % get reference (matrix with all triggered images) and compare with
    % given position, find image index with closest position
    
    ref = table2array(daq_table(:,1:2)); 
    % convert to array and use columns 1 &2
    
    [~, indx] = mink(dist(ref, coordinate'),numElem);
    % Chooses 'numElem' closest values

end
