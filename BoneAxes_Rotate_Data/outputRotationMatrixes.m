%By; QuocBao Vu
%Created: ~
%Last Modified: Dec. 31, 2012
%
%This function outputs the rotation matrix for rotations about an axes with
%angles of 90, 180, and 270
function rotationMatrixes = outputRotationMatrixes(angleInput, axisInput)
    %Determine the number of rotations
    numberRotations = size(axisInput, 2);
    
    %Convert from degrees to radians
    radInput = angleInput * (pi/180);
    
    %Cosine and Sine of the angles
    c = cos(radInput);
    s = sin(radInput);
    
    %Contruct a series of rotations matrices
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