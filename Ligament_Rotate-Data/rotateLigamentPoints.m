%By: QuocBao Vu
%Created: 11/24/2012
%Updated: 2/19/2013
%Version: 1
%
%This function takes the ligament points and rotates them in the order that
%the rotation matrixes are stored in the 3D array. The points are first
%translated to the origin, then rotated x amounts of times using the
%rotation matrix and then translated back to the new center point.

function newLig = rotateLigamentPoints(ligamentFile, oldCenter, newCenter, rotationMatrix)
    if (strcmpi(ligamentFile(end-3:end), '.txt'))
        %Read in the old ligament data
        oldLigaments = readLigamentFile(ligamentFile);
    elseif (strcmpi(ligamentFile(end-3:end), '.mat'))
        load(ligamentFile);
        oldLigaments = Ligs;
    end
        %Copy old ligament data to new data since some data are the same, only
        %the points will be rotated and updated
        newLig = oldLigaments;
        ligamentPoints = oldLigaments.Points;
        newLigamentPoints = ligamentPoints;
    
    for i =1:length(ligamentPoints)
        bonePoints = ligamentPoints{i}';
        newBonePoints = [];
        translatedPoints = [];
        finalPoints = [];
        if (~isempty(bonePoints))
            %Translate the points such that the old center is located at
            %the origin
            for j = 1:size(bonePoints, 2)
                translatedPoints(:,j) = bonePoints(:,j) - oldCenter;
            end
            
            %Rotate the matrix size(rotationmatrix,3) number of times
            for j = 1:size(rotationMatrix,3)
                rotatedPoints = rotationMatrix(:,:,j) * translatedPoints;
                translatedPoints = rotatedPoints;
            end
            
            %Translate the points such that the origin is located at the
            %new center
            for j =1:size(bonePoints, 2)
                finalPoints(:,j) = rotatedPoints(:,j) + newCenter;
            end
            
            newBonePoints = finalPoints';
        end
        newLigamentPoints{i} = newBonePoints;
    end
    
    newLig.Points = newLigamentPoints;
        
end

