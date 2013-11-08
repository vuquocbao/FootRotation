%By: QuocBao Vu
%Created: 11/24/2012
%Updated: 2/19/2013
%Version: 1
%
%This file takes the input volume and writes out the new volume to a dat
%file that will be later converted to IDL format. The input volume is
%centered in a 512 by 512 by 512 volume

function generateNewVolume(newDir, newVolume)
    len = length(newVolume);
    sz = size(newVolume);
    output = ones(len, len, len) * -512;
    
    output((len - sz(1) + 1):len, (len -sz(2) + 1):len, 1:sz(3)) = newVolume;
%     output = newVolume;

    fileID = fopen([newDir 'New_MR_ISO_Volume.dat'], 'w');
    fwrite(fileID, output, 'float');
    fclose(fileID);
end