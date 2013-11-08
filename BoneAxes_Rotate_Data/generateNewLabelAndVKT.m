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