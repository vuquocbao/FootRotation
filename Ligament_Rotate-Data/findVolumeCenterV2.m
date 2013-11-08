%By: QuocBao Vu
%Created: 2/19/2013
%Updated: 2/19/2013
%Version: 2
%
%This function finds the center of the old label and new label using the
%size of the two arrays not reading from rendering.txt
function [oldCenter, newCenter] = findVolumeCenterV2(oldV, newV)
    oldDim = size(oldV);
    oldCenter = (oldDim - 1)./2;
    oldCenter = oldCenter';
    
    newDim = size(newV);
    newCenter = (newDim - 1)./2;
    newCenter = newCenter';
end

