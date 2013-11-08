%Rotating MR_ISO_Label file and Markers
%By QuocBao
%Created: Feb. 23, 2012
%Last Modified: Dec. 21, 2012


clear all
close all
clc

%Set input and output Directory
global oldDir
global newDir
oldDir = 'F:\FEA_Gold_Foot\FEA_Gold_Standard_Original\';
newDir = 'F:\FEA_Gold_Foot\FEA_Gold_New\';

%Set which data to rotate
%Rotate Label   (yes == 1, no == 0)
%Rotate Points  (yes == 1, no == 0)
%Rotate Volume  (yes == 1, no == 0)

rotateLabelTF = 0;
rotatePointsTF = 1;
rotateVolumeTF = 0;

%Set the ligament file
ligamentFile = [oldDir 'Full_Lig_4thGen_foot_05-24-13.mat'];

%Set number of rotations that will be applied
numberRotations = 1;

%Set Axis of Rotation
%Z-axis is the vector normal to the screen positive out of screen
%Y-axis is the vertical vector postive is up
%X-axis is the horizontal vector positive to the right
%Use the right hand to figure out the positive and negetive directions

% Set which Axis to rotate about
% X         Y         Z

axisInput{1} = 'y';
% axisInput{2} = {'x'};

% Set how many degrees to rotated the foot around the axis please use
% 90, 180 or 270
angleInput(1) = 180;
% angleInput(2) = 90;

%Create the label array using the .dat file and load the MR_ISO volume from
%file
[oldDimensions, oldLabel] = makeLabelArray();
oldISOVolume = getMRISOVolumeData();

%Mark the ROI boundry with white slices in the MR-ISO volume using the
%values in segmentation results. This makes it easier to line up the the
%label data later
oldISOVolume = markROIBoundry(oldISOVolume, [newDir 'OldSegmentationResults.txt']);

%Rotate the label and volume using the axisInput and angleInput
label = oldLabel;
for i = 1:numberRotations
        newLabel = rotateLabel(label, axisInput{i}, angleInput(i));
        clear label
        label = newLabel;
    if (rotateVolumeTF)
        newVolume = rotateVolume(oldISOVolume, axisInput{i}, angleInput(i));
        clear oldISOVolume 
        oldISOVolume = newVolume;
    end
end

%Write the the newLabel information and then generate new vkt files
if (rotateLabelTF)
    generateNewLabelAndVKT(newLabel);
end

%Generate the new MR_ISO Volume
if (rotateVolumeTF)
    generateNewVolume(newDir, newVolume);
end

if (rotatePointsTF)
    %Calculate center of the old volume and the center of the new volume
    [oldCenter, newCenter] = findVolumeCenterV2(oldLabel, newLabel);
    %Output the corresponding rotation matrix for the right angle and axisInput
    rotationMatrix = outputRotationMatrixes(angleInput, axisInput);

    %Shift all the ligaments such that the center of the volume is located at
    %the origin and then rotate the points
    newLigamentPoints = rotateLigamentPoints(ligamentFile, oldCenter, newCenter, rotationMatrix);

    %Write the ligament file out to file
    WriteLigamentFileV2(newLigamentPoints, newDir, 'Full_Lig_4thGen_foot_05-24-13.txt');
end




