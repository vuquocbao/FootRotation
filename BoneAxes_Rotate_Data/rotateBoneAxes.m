function newFoot = rotateBoneAxes(oldFoot, oldCenter, newCenter, rotationMatrix)
    
    %To calculate new markers points. Translate the center of the points to
    %the origin. Rotate the matrix mulltiple times if needed. Then
    %Translate to the new center of the volume
    
%     oldCenter = oldCenter;
%     newCenter = newCenter;
    
    %Update Markers
    for i = 1:oldFoot.NBones{1}
        oldMarkers = cell2mat(oldFoot.Markers(:,:,i)');
        translatedPoints = zeros(3,4);
        finalPoints = zeros(3,4);
        if size(oldMarkers) == 0
            numberMarkers = 0;
        elseif size(oldMarkers) == [3 3]
            numberMarkers = 3;
        elseif size(oldMarkers) == [3 4]
            numberMarkers = 4;
        end
            
            %Translate points such that the old center will be at (0,0)
            for k = 1:numberMarkers
                translatedPoints(:,k) = oldMarkers(:,k) - oldCenter
            end
            
            %Rotate the matrix size(rotationMatrix,3) number of times
           
            for k = 1: size(rotationMatrix, 3)
                rotatedPoints = rotationMatrix(:,:,k) * translatedPoints;
                translatedPoints = rotatedPoints;
            end
            
            for k = 1:numberMarkers
                finalPoints(:,k) = rotatedPoints(:,k) + newCenter;
            end
            
        newFoot.Markers(:,:,i) = finalPoints'
        
    end
    

            
    %Update Origin
    for j = 1:oldFoot.NBones{1}
        oldBoneCenter = cell2mat(oldFoot.Origin(j,:)');
        
        if size(oldBoneCenter) == [0 0]
            finalCenter = zeros(3,1);
        else 
            translatedCenter = oldBoneCenter - oldCenter;
            
            for k = 1:size(rotationMatrix, 3)
                rotatedCenter = rotationMatrix(:,:,k) * translatedCenter;
                translatedCenter = rotatedCenter;
            end
            
            finalCenter = (rotatedCenter + newCenter)';
        end
        
    newFoot.Origin(j,:) = finalCenter'
    end
    
    %Update Normals
    
    for h = 1:oldFoot.NBones{1};
        oldAxis = cell2mat(oldFoot.Normal(:,:,h)')
        
        if size(oldAxis) == [0 0]
            newAxis = zeros(3,3);
        else
            for k = 1:size(rotationMatrix, 3)
                finalAxis = rotationMatrix(:,:,k) * oldAxis;
                oldAxis = finalAxis;
            end
        end
        
        newFoot.Normal(:,:,h) = finalAxis';
    end
    
    newFoot.NBones = oldFoot.NBones;
    newFoot.BoneName = oldFoot.BoneName;

end