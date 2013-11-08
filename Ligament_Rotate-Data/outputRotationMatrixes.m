%By: QuocBao Vu
%Created: 2/28/2012
%Updated: 2/19/2013
%Version: 1
%
%This function outputs a list of rotation matrixes to rotate points around
%the list of input angle and axis in the input order.

function rotationMatrixes = outputRotationMatrixes(angleInput, axisInput)
    numberRotations = size(axisInput, 2);
    radInput = angleInput * (pi/180);
    
    c = cos(radInput);
    s = sin(radInput);
    
    for i = 1: numberRotations
        if strncmpi(axisInput{i}, 'x', 1)
            rotationMatrixes(:,:,i) = [1 0 0;0 c(i) -s(i); 0 s(i) c(i)];
        elseif strncmpi(axisInput{i}, 'y', 1)
            rotationMatrixes(:,:,i) = [c(i) 0 s(i); 0 1 0; -s(i) 0 c(i)];
        elseif strncmpi(axisInput{i}, 'z', 1)
            rotationMatrixes(:,:,i) = [c(i) -s(i) 0; s(i) c(i) 0; 0 0 1];
        end
    end

end