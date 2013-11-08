%Rotating MR_ISO_Label file and Markers
%By QuocBao
%Created: Feb. 23, 2012


clear all
close all
clc

%Set the old directory containing the data to be rotated and the newDir the
%newly rotated data
global oldDir
global newDir
oldDir = 'D:\Golds\CorAntResegmented\';
newDir = 'D:\Golds\SP-XD\';

%Set which data to rotate
%Rotate Label   (yes == 1, no == 0)
%Rotate Points  (yes == 1, no == 0)
%Rotate Volume  (yes == 1, no == 0)

rotateLabelTF = 0;
rotatePointsTF = 1;
rotateVolumeTF = 0;

%Set number of rotations
numberRotations = 1;

%Set Axis of Rotation
%Z-axis is the vector normal to the screen positive out of screen
%Y-axis is the vertical vector postive is up
%X-axis is the horizontal vector positive to the right
%Use the right hand to figure out the positive and negetive directions

% Set which Axis to rotate about
% X         Y         Z
axisInput{1} = {'y'};
% axisInput{2} = {'x'};

% Set how many degrees to rotated the foot around the axis please use
% 90, 180 or 270
angleInput(1) = 270;
% angleInput(2) = 90;

%Create a label array using the .dat file and read in the MR_ISO volume
[oldDimensions, oldLabel] = makeLabelArray();
oldISOVolume = getMRISOVolumeData();

oldISOVolume = markROIBoundry(oldISOVolume, [newDir 'OldSegmentationResults.txt']);

%Rotate the label using the axisInput and angleInput
label = oldLabel;
for i = 1:numberRotations
    newLabel = rotateLabel(label, axisInput{i}, angleInput(i));
    newVolume = rotateVolume(oldISOVolume, axisInput{i}, angleInput(i));
    clear label
    clear oldISOVolume
    label = newLabel;
    oldISOVolume = newVolume;
end

%Write the the newLabel information and then generate new vkt files
if (rotateLabelTF)
    generateNewLabelAndVKT(newLabel);
end

%Generate and write the new MR_ISO volume to file
if (rotateVolumeTF)
    generateNewVolume(newDir, newVolume);
end

if (rotatePointsTF)
    %Calculate center of the old volume and the center of the new volume
    [oldCenter, newCenter] = findVolumeCenter(oldDimensions);

    %Get the cooresponding rotation matrix for each angleInput and axisInput
    rotationMatrix = outputRotationMatrixes(angleInput, axisInput);

    %Read in the bone axes data
    oldFootMarkers = ReadTemplate([oldDir 'BoneAxes.txt']);

    %Shift all the markers such that the center of the volume is located at the
    %origina and then rotate the markers using the rotation matrices and then
    %shift the points such that center of the volume is located at the new
    %center
    newFootMarkers = rotateBoneAxes(oldFootMarkers, oldCenter, newCenter, rotationMatrix);

    %Write the newly rotated data to file
    writeBoneAxes(newFootMarkers);
end





