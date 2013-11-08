function generateNewVolume(newDir, newVolume)
    len = length(newVolume);
    sz = size(newVolume);
    output = ones(len, len, len) * -1024;
    
    output((len - sz(1) + 1):len, (len -sz(2) + 1):len, 1:sz(3)) = newVolume;
%     output = newVolume;

    fileID = fopen([newDir 'New_MR_ISO_Volume.dat'], 'w');
    fwrite(fileID, output, 'float');
    fclose(fileID);
end