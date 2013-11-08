%By: QuocBao Vu
%Created: 11/24/2012
%Updated: 2/19/2013
%Version: 1
%
%This function takes in the 3D volume of the subject and marks the ROI
%boundry with white planes such that lining up label in IDL will be much
%easier. The cropping values are read in from segmentationresults.txt and
%white slices are places at those cropping positions. The output is the
%newly marked volume.

function [markedVolume] = markROIBoundry(oldVolume, oldSegmentationFile)

    %Use java API to read in the segmenationresults text file that stores
    %the old roi boundry values
    javaFile = java.io.File(oldSegmentationFile);
    javaScanner = java.util.Scanner(javaFile);
    
    javaScanner.nextLine();
    javaScanner.nextLine();
    
    javaTokenScanner = java.util.Scanner(javaScanner.nextLine());
    
    %Read the cropping values for the ROI, adjust for index difference by
    %adding one to the values
    cropValue = [];
    index = 1;
    while (javaTokenScanner.hasNextInt())
        cropValue(index) = javaTokenScanner.nextInt();
        index = index + 1;
    end
    cropValue = cropValue + 1;
    
    %Marked the boundry of the old ROI so it is easier to line up. The
    %boundry will be replace with a gray plane to indicate the old boundry
    markedVolume = oldVolume;
    
    markedVolume(cropValue(1),:,:) = 1024;
    markedVolume(cropValue(2),:,:) = 1025;
    markedVolume(:,cropValue(3),:) = 1025;
    markedVolume(:,cropValue(4),:) = 1025;
    markedVolume(:,:,cropValue(5)) = 1025;
    markedVolume(:,:,cropValue(6)) = 1025;
end

