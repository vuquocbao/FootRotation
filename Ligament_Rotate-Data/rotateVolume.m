function newVolume = rotateVolume(volume, axisInput, angleInput)
    if strncmpi(axisInput, 'x', 1);
        if angleInput == 180
            Y = flipdim(volume,2);
            newVolume = flipdim(Y,3);
        elseif angleInput == 90
            v = [1 3 2];
            Y = permute(volume, v);
            newVolume = flipdim(Y,2);
        elseif angleInput == 270
            v = [1 3 2];
            Y = permute(volume, v);
            newVolume = flipdim (Y,3);
        end
    elseif strncmpi(axisInput, 'y', 1)
        if angleInput == 180
            Y = flipdim(volume ,1);
            newVolume = flipdim(Y,3);
        elseif angleInput == 90
            v = [3 2 1];
            Y = permute(volume, v);
            newVolume = flipdim(Y,3);
        elseif angleInput == 270
            v = [3 2 1];
            Y = permute(volume,v);
            newVolume = flipdim(Y,1);
        end
    else strncmpi(axisInput, 'z', 1)
        if angleInput == 180
           Y = flipdim(volume,1);
           newVolume = flipdim (Y,2);
        elseif angleInput == 90
            v = [2 1 3];
            Y = permute(volume,v);
            newVolume = flipdim(Y,1);
        elseif angleInput == 270
            v = [3 2 1];
            Y = permute(volume,v);
            newVolume = flipdim(Y,2);
        end
    end
end