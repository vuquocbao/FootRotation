function [ligamentData] = readLigamentFile(inputFileName)
%This function read in the any ligament text file for the ligament template
%matching study. This function utilize java command to read in the data
%since javas scanner is more robust and easier to use than matlabs fscanf.
%The only input is the file to be read. If the file doesn't exist a error
%will be thrown

    %set the file to input file
    file = inputFileName;
    
    %create java file using File class and check if the file exist
    javaFile = java.io.File(file);
    if (~javaFile.exists())
        error('IO Exception: File does not exist');
    end
    
    %creat a java Scanner class using the java file to read in the text
    %file
    javaFileScanner = java.util.Scanner(javaFile);

    %Excutes while the scanner has more lines to read
    while (javaFileScanner.hasNextLine())
        %Read in the bone index line and read the bone index
        javaLineScanner = java.util.Scanner(javaFileScanner.nextLine());
        boneID = javaLineScanner.nextInt();
        newBone = false;

        %Reset the counter
        pointIndex = 1;
        ligamentIndex = 1;

        %Initialize and clear old varibles
        ligamentIDs = [];
        ligamentsPoint = [];
        ligamentsName = {};

        %Read in the ID numbers, points and ligament names for the bone
        while (~newBone && javaFileScanner.hasNextLine());
            line = javaFileScanner.nextLine();
            javaLineScanner = java.util.Scanner(line);
            
            %Check to see if the line read in is a blank line or it has
            %data. If there is no data that means there is a new bone and
            %that we should stop reading data for the current bone.
            %WARNING: There must be a blank line between each set of data
            %for each bone or this code will crash.
            if (javaLineScanner.hasNextInt())
                %Read in the ligament ID and then points
                ligamentIDs(pointIndex, 1) = javaLineScanner.nextInt();
                ligamentsPoint(pointIndex, 1) = javaLineScanner.nextDouble();
                ligamentsPoint(pointIndex, 2) = javaLineScanner.nextDouble();
                ligamentsPoint(pointIndex, 3) = javaLineScanner.nextDouble();

                pointIndex = pointIndex + 1;
                
                %Read in the ligament Name is there is one
                if (javaLineScanner.hasNext)
                    ligamentsName{ligamentIndex, 1}  = char(javaLineScanner.next());
                    ligamentIndex = ligamentIndex + 1;
                end
            else 
                %To tell if it is a new bone
                newBone = true;
            end
        end

        %Save the bone data to cell array
        ligamentsIDData{boneID, 1} = ligamentIDs;
        ligamentsPointData{boneID, 1} = ligamentsPoint;
        ligamentsNameData{boneID, 1} = ligamentsName;
    end

    %Create a structure to store the data using the cell array
    ligamentData.IDs = ligamentsIDData;
    ligamentData.Points = ligamentsPointData;
    ligamentData.Names = ligamentsNameData;
end