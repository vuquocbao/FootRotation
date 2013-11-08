%By: QuocBao Vu
%Created: ~
%Updated: Dec. 31, 2012
%
%This function reads the label file using the rendering.txt to obtain the
%dimensions and reading the raw data from MR_ISO_Label.dat.

function [dimensions, label] = makeLabelArray()
    global oldDir
    
    %Open and read the rendering.txt file for the size of the label
    fid = fopen([oldDir 'rendering.txt'], 'r');
    dimensions = fscanf(fid,'%d',3);
    fclose(fid);

    %Open and read the data in the MR_ISO_Label.data file
    file = [oldDir 'MR_ISO_Label.dat'];
    fid = fopen(file,'r');
    label = fread(fid, 'char');
    fclose(fid);

    %Reshape the data from MR_ISO_Label.dat to the dimension read from the
    %rendering.tx file.
    label = reshape(label, dimensions(1), dimensions(2), dimensions(3));
end