function [oldCenter, newCenter] = findVolumeCenter(oldDimensions)
    global newDir
    
    oldCenter = (oldDimensions - 1) / 2;

    fid = fopen([newDir 'rendering.txt'], 'r');
    dimension = fscanf(fid, '%d', 3);
    fclose(fid);

    newCenter = (dimension - 1) / 2;

end
