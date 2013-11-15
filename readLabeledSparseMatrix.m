function [X,Y] = readLabeledSparseMatrix (fileLocation)

    
    fid = fopen(fileLocation,'r');
    tline = fgets(fid);
    
    X = sparse(1,14601);
    Y = [];
    
    currentI = 1;
    while ischar(tline)
        split = textscan(tline,'','delimiter',' :');
        LabelCell = split(1,1);
        Y(1,currentI) = LabelCell{1};
        
        for i = 2:2:size(split,2)
            Jcell = split(1,i);
            Scell = split(1,i+1);
            X(currentI, Jcell{1}) = Scell{1};
        end
        
        currentI = currentI + 1;
        tline = fgets(fid);
    end
    
    Y = Y';
    
    fclose(fid);
    
end