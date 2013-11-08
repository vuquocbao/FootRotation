%By: QuocBao Vu
%Created: 7/26/2012
%Updated: 2/19/2013
%Version: 1
%
%This function writes out the new label file to .dat format and also
%generates the new vtk and stl surfaces by calling Vol2Contour.exe in dos

function generateNewLabelAndVKT(newLabel)
    global newDir

    'Writing new MR_ISO_Label.dat file'
    fid = fopen([newDir 'MR_ISO_Label.dat'], 'w');
    fwrite(fid, newLabel);
    fclose(fid);

    %Generate New vkt files
    'Generating new vtk files'
    dos(['Vol2Contour ' newDir 'rendering.txt' ' /stl']);
    'Viewing new surface'
end