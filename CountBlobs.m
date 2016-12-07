function [ blobsize,nsize,biggestblob,labeled ] = CountBlobs( mat )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

labeled = bwlabel(mat,4);
blobnumber = 1:max(labeled(:));
blobIsize = histc(labeled(:),blobnumber);
[~,maxind] = max(blobIsize);
biggestblob = zeros(size(labeled));
biggestblob(labeled == maxind) = 1;
blobsize = 1:100;
nsize = histc(blobIsize,blobsize);
end

