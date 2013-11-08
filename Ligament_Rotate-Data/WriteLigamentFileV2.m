%By: QuocBao Vu
%Created: 12/1/2012
%Updated: 2/15/2013
%Version: 1
%
%This function write out the ligament file using the passed in data that
%contains the ligament points, the names of the connection and the node
%number. This function is setup to take into account that there are 3
%markers for each ligament. The function inputs are the ligamentData
%structure the subjectDirectory and an optional filename. The default name
%is set to be LigamentMarkerData.txt

function WriteLigamentFileV2(ligamentData, subjectDirectory, fileName, mode)
    %Check if a output file name is specified
    if (nargin == 3)
        outputFileName = fileName;
    else
        outputFileName = 'LigamentMarkerData.txt';
    end
    
    %Set default mode to 0 for reading 3 nodes per connection
    if (nargin ~= 4)
        mode = 0;
    end
    
    %open the file for writing
    fid = fopen([subjectDirectory outputFileName], 'wt');
    
    %extract the points, ids, and name from the ligamentData structure and
    %compute the number of bones
    points = ligamentData.Points;
    ids = ligamentData.IDs;
    name = ligamentData.Names;
    nBones = length(points);
    
    %write the data to file
    for i = 1:nBones
        %extract the markers, id, and ligament name for bone with bone
        %index i
        boneMarkers = points{i};
        boneIDs = ids{i};
        boneLigamentNames = name{i};
        
        %print the bone index
        fprintf(fid, '%i\n', i);
        
        %print the id, marker, and ligament name. There is a if statment
        %because right now there are 3 markers per ligament so the ligament
        %name is only printed on the 1st, 4th, 7th point and so on.
        %mod(j -1, 3) is to find when we should print the ligament name
        for j = 1:size(boneMarkers, 1);
            if (mode)
                fprintf(fid, 'i%\t%6f\t%6f\t%6f\t%s\n', boneIDs(j, 1), ...
                    boneMarker(j, 1), boneMarker(j, 2), boneMarker(j, 3), ...
                    boneLigamentNames{j});
            else
                if (mod(j -1, 3) == 0)
                    fprintf(fid, '%i\t%6f\t%6f\t%6f\t%s\n', boneIDs(j, 1), ...
                        boneMarkers(j,1), boneMarkers(j,2), boneMarkers(j, 3), ...
                        boneLigamentNames{(j -1)/3 + 1});
                else
                    fprintf(fid, '%i\t%6f\t%6f\t%6f\n', boneIDs(j, 1), ...
                        boneMarkers(j,1), boneMarkers(j,2), boneMarkers(j, 3));
                end
            end
        end
        
        %print the newline to denote an new bone
        fprintf(fid, '\n');
    end
    fclose(fid);
                    
end

