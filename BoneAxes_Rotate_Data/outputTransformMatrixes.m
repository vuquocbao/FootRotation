function [Rot, Trans] = outputTransformMatrixes(AxisInput, AngleInput,dim)

%Notes: Current Apporach is to rotate the markers about the x,y or z axis
%       then translate the points to the proper location.
%
%   Assume the dimension of the volume of the original or old gold standerd 
%   feet is [dim(1),dim(2),dim(3)] to make it easy to understand how much
%   to translate the rotated markers by.
%
%   if AxisInput=1 and AngleInput=90 you must rotate markers 90 degrees
%   about the x-axis and then translate up along the y axis by dim(3)amount. 
%   id Axisinput=1 and AngleInput=270 you must rotate markers 270 degrees
%   about the x-asix and then translate in the positve z-axis by dim(2)
%   amount.
%   if AxisInput=3 and AngleInput=180 you must rotate markers 270 degrees
%   about the z-axis and then translate along the z-axis by dim(3) and
%   y-axis by dim(2)

%   if AxisInput=2 and AngleInput=90 you must roate markers 90 degress
%   about y axis and then translate along the poistive z-axis by dim(1)
%   amount.
%   if AxisInput = 2 and AngleInput = 270 you must rotate markers 270
%   degrees about the y-axis and then translate along the positve x-axis
%   by dim(3) amoutn
%   if AxisInput=3 and AngleInput=180 you must rotate markers 270 degrees
%   about the z-axis and then translate along the z-axis by dim(3) and
%   x-axis by dim(2)

%   if AxisInput=3 and AngleInput=90 you must rotate markers 90 degrees
%   aboutthe y-axix and then translate along the positive x-axis by dim(2)
%   amount.
%   if AxisInput=3 and AngleInput=270 you must rotate markers 270 degrees
%   about the z-axis and then translate along the positve y-axis by dim(1)
%   amount
%   if AxisInput=3 and AngleInput=180 you must rotate markers 270 degrees
%   about the z-axis and then translate along the x-axis by dim(1) and
%   y-axis by dim(3)

%Convert Angle from degree to Radians and Cos/Sin of Theta

RadInput = AngleInput*(pi/180);

c = cos(RadInput);
s = sin(RadInput);

%--------------List of Rotation and Translation Matrixs--------------------
%X-axis Rotation and Tranlation in the 
Rotx=[1 0 0;0 c -s; 0 s c];

%Y-axis Rotation
Roty=[c 0 s; 0 1 0; -s 0 c];

%Z-axis Rotation
Rotz=[c -s 0; s c 0; 0 0 1];

%Set the Rotatation Matrix and Translation Matrix
x=0, y=0, z=0;
if AxisInput==1;
    Rot=Rotx;
    if AngleInput==90;
        y=dim(3);
    elseif AngleInput==270;
        z=dim(2);
    else AngleInput==180;
        z=dim(3);
        y=dim(2);
    end
elseif AxisInput==2;
    Rot=Roty;
    if AngleInput==90;
        z=dim(1);
    elseif AngleInput==270;
        x=dim(3);
    else AngleInput==180;
        z=dim(3);
        x=dim(1);
    end
else AxisInput==3;
    Rot=Rotz
    if AngleInput==90;
        x=dim(2);
    elseif AngleInput==270;
        y=dim(1);
    else AngleInput==180;
        y=dim(2);
        x=dim(1);
    end
end

Trans = [x - 1; y ; z - 1];
end