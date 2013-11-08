function newVolume = rotateVolume(volume, axisInput, angleInput)
    if strncmpi(axisInput, 'x', 1);
        %Rotating 180 degress about the x axis
        if angleInput == 180
            Y = flipdim(volume,2);
            newVolume = flipdim(Y,3);
        %Rotating 90 degress about the x axis    
        elseif angleInput == 90
            v = [1 3 2];
            Y = permute(volume, v);
            newVolume = flipdim(Y,2);
        %Rotating 270 degress about the x axis
        elseif angleInput == 270
            v = [1 3 2];
            Y = permute(volume, v);
            newVolume = flipdim (Y,3);
        end
    elseif strncmpi(axisInput, 'y', 1)
        %Rotating 180 degrees about the y - axis
        if angleInput == 180
            Y = flipdim(volume ,1);
            newVolume = flipdim(Y,3);
        %Rotating 90 degrees about the y - axis
        elseif angleInput == 90
            v = [3 2 1];
            Y = permute(volume, v);
            newVolume = flipdim(Y,3);
        %Rotating 270 degrees about the y - axis
        elseif angleInput == 270
            v = [3 2 1];
            Y = permute(volume,v);
            newVolume = flipdim(Y,1);
        end
    else strncmpi(axisInput, 'z', 1)
        %Rotating 180 degrees about the z - axis
        if angleInput == 180
           Y = flipdim(volume,1);
           newVolume = flipdim (Y,2);
        %Rotating 90 degrees about the z - axis
        elseif angleInput == 90
            v = [2 1 3];
            Y = permute(volume,v);
            newVolume = flipdim(Y,1);
        %Rotating 270 degrees about the z - axis
        elseif angleInput == 270
            v = [3 2 1];
            Y = permute(volume,v);
            newVolume = flipdim(Y,2);
        end
    end
end