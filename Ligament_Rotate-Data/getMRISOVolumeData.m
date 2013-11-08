%By: QuocBao Vu
%Created: 9/4/2012
%Updated: 2/19/2012
%Version: 1
%
%This function reads in the MR_ISO_Volume.dat file that was converted from
%a .sav to .dat in IDL using the old dimesnions to reshape the data in to
%the correct size

function oldVolume = getMRISOVolumeData()
    global newDir;

    
    fileID = fopen([newDir 'oldDimensions.txt']);
    dims(1:3) = fscanf(fileID, '%i', 3);
    
    fid = fopen([newDir 'MR_ISO_VOL.dat']);
    oldVolume = fread(fid, inf, 'float');
    fclose(fid);
    
    oldVolume = reshape(oldVolume, dims);
    
    
end