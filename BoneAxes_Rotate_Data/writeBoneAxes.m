function writeBoneAxes(Bones)

    global newDir
    
    subjDir = newDir;

    nBones=Bones.NBones{1,1};
    % nBones=Bones.Num;  % Original Line
    NewPnts = Bones.Markers;
    NewOrient = Bones.Normal;
    NewCent = Bones.Origin;
    % Bns = Bones.Bns;

    fid = fopen([subjDir 'BoneAxes.txt'], 'w');
    fprintf(fid, 'Number of Bones: %d\n\n', nBones);

    for i=1:nBones
        %     i = Bns(t, 1);
        Name = char(Bones.BoneName{i});
    %     Name = Bones.Name{i};  %Original
        fprintf(fid, '%2.0f. %s:\n', i, Name);  % Example -> 4. Calcaneus:
        if ((NewPnts(1,1,i) == 0)&&(NewPnts(1,2,i) == 0)&&(NewPnts(1,3,i) == 0))  % Could first line be all zeros and still have data?
            fprintf(fid, '\tN/A \n\n');
        else
            if ((NewPnts(4,1,i) == 0)&&(NewPnts(4,2,i) == 0)&&(NewPnts(4,3,i) == 0))
                En = 3;
            else
                En = 4;
            end
            for j=1:En
                fprintf(fid, '\tMarker %g: %5.6f, %5.6f, %5.6f \n', j, NewPnts(j,1,i), NewPnts(j,2,i), NewPnts(j,3,i));
            end
            fprintf(fid, '\tOri: %5.6f, %5.6f, %5.6f\n', NewCent(i,1), NewCent(i,2), NewCent(i,3));
            fprintf(fid, '\tNx: %5.6f, %5.6f, %5.6f\n',  Bones.Normal(1,1,i), Bones.Normal(1,2,i), Bones.Normal(1,3,i));
            fprintf(fid, '\tNy: %5.6f, %5.6f, %5.6f\n',  Bones.Normal(2,1,i), Bones.Normal(2,2,i), Bones.Normal(2,3,i));
            fprintf(fid, '\tNz: %5.6f, %5.6f, %5.6f\n\n',Bones.Normal(3,1,i), Bones.Normal(3,2,i), Bones.Normal(3,3,i));
        end
    end

    fclose(fid);

end