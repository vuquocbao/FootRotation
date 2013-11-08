%By: QuocBao Vu
%Created: 9/13/2012
%Updated: 2/19/2013
%Version: 1
%
%This function reads in the old MR_ISO_Label and shapes the label in to the
%correct dimension such that modification can be done. The output is the
%dimensions of the label and the label reshaped into a 3D array

function [dimensions, label] = makeLabelArray()
    global oldDir

    fid = fopen([oldDir 'rendering.txt'], 'r');
    dimensions = fscanf(fid,'%d',3);
    fclose(fid);

    file = [oldDir 'MR_ISO_Label.dat'];
    fid = fopen(file,'r');
    label = fread(fid, 'char');
    fclose(fid);

    label = reshape(label, dimensions(1), dimensions(2), dimensions(3));
end