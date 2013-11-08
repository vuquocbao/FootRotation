function Data = ReadTemplate(Loc)

% read in template points  (anything need to change to use with other warp
% types??

% % testing
% clear all; clc;
% BaseDir = 'D:\Old_CT_Feet\';
% FilNam = 'NA05_R_BoneAxes_Standard.txt';
% Loc = [BaseDir FilNam];

%----------------Program---------------------------
fid = fopen(Loc, 'r');

jnk = textscan(fid, '%[^:] %c', 1);      % "Number Bones:"
Data.NBones = textscan(fid, '%f', 1);

for i=1:Data.NBones{:}(:)
    jnk = textscan(fid, '%[^.] %c',1);  % 1. or 2., or... 19.
    Data.BoneName(i,1) = textscan(fid, '%[^:]', 1);
    jnk = textscan(fid,'%c', 1);
    if     ((strncmp(cell2mat(Data.BoneName{i,1}), 'Met', 3) == 1) ||...  % Check if first three characters are "Met"
            (strncmp(cell2mat(Data.BoneName{i,1}), 'Pro', 3) == 1) ||...
            (strncmp(cell2mat(Data.BoneName{i,1}), 'Dis', 3) == 1));
        j=4;
    else j=3;
    end
    if ((strcmp(cell2mat(Data.BoneName{i}), 'Fibula') == 0) &&...
            (strcmp(cell2mat(Data.BoneName{i}), 'IntCun') == 0) &&...
            (strcmp(cell2mat(Data.BoneName{i}), 'LatCun') == 0))
        for m=1:j
            jnk = textscan(fid, '%[^:] %c', 1); % Marker #:
            Data.Markers(m, 1:3, i) = textscan(fid, '%20.15f %20.15f %20.15f', 1, 'delimiter', ',');
        end
        jnk = textscan(fid, '%[^:] %c', 1); % Ori:
        Data.Origin(i, :) = textscan(fid, '%20.15f %20.15f %20.15f', 1, 'delimiter', ',');
        for n=1:3
            jnk = textscan(fid, '%[^:] %c', 1); % Nx,Ny,Nz 1:
            Data.Normal(n, 1:3, i) = textscan(fid, '%20.15f %20.15f %20.15f', 1, 'delimiter', ',');
        end
    else
        jnk = textscan(fid, '%[^1234567890]', 1); % "N/A"
    end
end
fclose(fid);

end