%By: QuocBao Vu
%Created: 9/4/2012
%Modified: 2/19/2013
%Version: 1
%
%This function takes the input label file and rotate the array  around the
%input axis and input angle by premuting the array. The output is the
%rotated array. Rotatations can only be done in 90, 180, 270 degrees

function NewLabel = rotateLabel(label, axisInput, angleInput)

    if strncmpi(axisInput, 'x', 1);
        if angleInput == 180
            Y = flipdim(label,2);
            NewLabel = flipdim(Y,3);
        elseif angleInput == 90
            v = [1 3 2];
            Y = permute(label, v);
            NewLabel = flipdim(Y,2);
        elseif angleInput == 270
            v = [1 3 2];
            Y = permute(label, v);
            NewLabel = flipdim (Y,3);
        end
    elseif strncmpi(axisInput, 'y', 1)
        if angleInput == 180;
            Y = flipdim(label ,1);
            NewLabel = flipdim(Y,3);
        elseif angleInput == 90
            v = [3 2 1];
            Y = permute(label, v);
            NewLabel = flipdim(Y,3);
        elseif angleInput == 270
            v = [3 2 1];
            Y = permute(label,v);
            NewLabel = flipdim(Y,1);
        end
    else strncmpi(axisInput, 'z', 1)
        if angleInput == 180;
           Y = flipdim(label,1);
           NewLabel = flipdim (Y,2);
        elseif angleInput == 90
            v = [2 1 3];
            Y = permute(label,v);
            NewLabel = flipdim(Y,1);
        elseif angleInput == 270
            v = [3 2 1];
            Y = permute(label,v);
            NewLabel = flipdim(Y,2);
        end
    end
end