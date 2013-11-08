function oldVolume = getMRISOVolumeData()
    global newDir;

    
    fileID = fopen([newDir 'oldDimensions.txt']);
    dims(1:3) = fscanf(fileID, '%i', 3);
    
    fid = fopen([newDir 'MR_ISO_VOL.dat']);
    oldVolume = fread(fid, inf, 'float');
    fclose(fid);
    
    oldVolume = reshape(oldVolume, dims);
    
    
end