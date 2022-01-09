%% Assessment 2
%clearing the console
clear; clc; close all;

%% Variables

debugMode = 0;

minArea = 1000;
maxArea = 50000;

circleCircularity = 0.93;
squareCircularity = 0.70;
triangleCircularity =0.55;

circleThresholdMultiplication = 1.5;
squareThresholdMultiplication = 1.25;
triangleThresholdMultiplication = 1.5;

movingAngles = [90, round(90*2.87), 90, 90];

firstBlobCentroidThreshold = 150;
secondBlobCentroidThreshold = 250;

armLocation = [101,290];
tempIntialLocation = [0,0];
tempFinalLocation = [0,0];


%% Getting the image chromacity colours and seperate blobs in the layout

%Note: To pause the script just have a line with "pause;" on it

im = iread('layout1.png');

imNormal = double(im)/255;
imNormalGamma = imNormal.^2.5;
%Seperating image into 3 planes
imRed = imNormalGamma(:,:,1);
imGreen = imNormalGamma(:,:,2);
imBlue = imNormalGamma(:,:,3);
%Getting the chromacity
imb = imBlue./(imRed+imGreen+imBlue);
imr = imRed./(imRed+imGreen+imBlue);
img = imGreen./(imRed+imGreen+imBlue);
%Getting the blobs
imbThings = imb>0.5;
imrThings = imr>0.5;
imgThings = img>0.5;

%% Blue blobs

b = iblobs(imbThings, 'area',[minArea,maxArea],'boundary');

bx = 1:length(b);
by = 1:length(b);

for i=1:length(b)
    bx(i)=b(i).uc;
    by(i)=b(i).vc;
end

%% Red blobs

r = iblobs(imrThings, 'area',[minArea,maxArea],'boundary');

rBound = zeros([1 length(r)]);

for i=1:length(r)
    %Gets the horizontal co ord of the centroid and the vertical co ord
    %Checks it against the blue dots
    if(r(i).uc<min(bx)||r(i).uc>max(bx) || r(i).vc<min(by) || r(i).vc>max(by) && r(i).circularity>0.4 )
        rBound(i)=1;
    end
end

%% Green blobs
g = iblobs(imgThings, 'area',[minArea,maxArea],'boundary');

gBound = zeros([1 length(g)]);

for i=1:length(g)
    if(g(i).uc<min(bx)||g(i).uc>max(bx)|| g(i).vc<min(by) || g(i).vc>max(by))
        gBound(i)=1;
    end
end

%% Finding the shapes we need to test

% setting up the threshold factors
% loop through all the blobs and check their area and store the area of the
% object within the total of that shapes area and increase the total
% then average out the values, if it is greater than the average than it is
% a big size, while if it is smaller then it is a small shape.

circleAreaTotal = 0;
squareAreaTotal = 0;
triangleAreaTotal= 0;

circleTotal = 0;
squareTotal = 0;
triangleTotal = 0;

for i=1:length(rBound)
    if(rBound(i)~=1)
        if r(i).circularity>circleCircularity
            circleTotal = circleTotal+1;
            circleAreaTotal = circleAreaTotal + r(i).area;
        elseif r(i).circularity >squareCircularity
            squareTotal = squareTotal+1;
            squareAreaTotal = squareAreaTotal + r(i).area;
        elseif r(i).circularity >triangleCircularity
            triangleTotal = triangleTotal+1;
            triangleAreaTotal = triangleAreaTotal + r(i).area;
        end
    end
end

for i=1:length(gBound)
    if(gBound(i)~=1)
        if g(i).circularity>circleCircularity
            circleTotal = circleTotal+1;
            circleAreaTotal = circleAreaTotal + g(i).area;
        elseif g(i).circularity >squareCircularity
            squareTotal = squareTotal+1;
            squareAreaTotal = squareAreaTotal + g(i).area;
        elseif g(i).circularity >triangleCircularity
            triangleTotal = triangleTotal+1;
            triangleAreaTotal = triangleAreaTotal + g(i).area;
        end
    end
end

circleThreshold = circleAreaTotal/circleTotal;

squareThreshold = squareAreaTotal/squareTotal;

triangleThreshold = triangleAreaTotal/triangleTotal;

%% Finding the intial objects

imIntial = iread('intial1.png');

imNormalIntial = double(imIntial)/255;
imNormalGammaIntial = imNormalIntial.^2.5;
%Seperating image into 3 planes
imRedIntial = imNormalGammaIntial(:,:,1);
imGreenIntial = imNormalGammaIntial(:,:,2);
imBlueIntial = imNormalGammaIntial(:,:,3);
%Getting the chromacity
imbIntial = imBlueIntial./(imRedIntial+imGreenIntial+imBlueIntial);
imrIntial = imRedIntial./(imRedIntial+imGreenIntial+imBlueIntial);
imgIntial = imGreenIntial./(imRedIntial+imGreenIntial+imBlueIntial);
%Getting the blobs
imbThingsIntial = imbIntial>0.5;
imrThingsIntial = imrIntial>0.5;
imgThingsIntial = imgIntial>0.5;

rIntial = iblobs(imrThingsIntial, 'area',[minArea,maxArea],'boundary');
gIntial = iblobs(imgThingsIntial, 'area',[minArea,maxArea],'boundary');

locationSquareThreshold = squareThreshold*squareThresholdMultiplication;
locationCircleThreshold = circleThreshold*circleThresholdMultiplication;
locationTriangleThreshold = triangleThreshold*triangleThresholdMultiplication;

total =1;

intialOrder = [ 0 0; 0 0; 0 0];

%Intial order is the order of which the blobs occur
%the first row relates to the first occuring blob
%the second row relates to the second and so on
%the first column says if it is red = 1 or green = 2
%the second column is the blob id

for i=1:length(rIntial)
    if rIntial(i).uc <firstBlobCentroidThreshold
        intialOrder(1,1) = 1;
        intialOrder(1,2) = i;
    elseif rIntial(i).uc >firstBlobCentroidThreshold+1 &&  rIntial(i).uc <secondBlobCentroidThreshold
        intialOrder(2,1) = 1;
        intialOrder(2,2) = i;
    elseif rIntial(i).uc >secondBlobCentroidThreshold+1
        intialOrder(3,1) = 1;
        intialOrder(3,2) = i;
    end
end

for i=1:length(gIntial)
    if  gIntial(i).uc <firstBlobCentroidThreshold
        intialOrder(1,1) = 2;
        intialOrder(1,2) = i;
    elseif gIntial(i).uc >firstBlobCentroidThreshold+1 &&  gIntial(i).uc <secondBlobCentroidThreshold
        intialOrder(2,1) = 2;
        intialOrder(2,2) = i;
    elseif gIntial(i).uc >secondBlobCentroidThreshold+1
        intialOrder(3,1) = 2;
        intialOrder(3,2) = i;
    end
end

% setting up the intial variable
% intial goes colour, shape, size, colour is 1 for red, 2 for green
% 1 for circle, 2 for square and 3 for triangle
% 1 for small 2 for large

fprintf('Intial locations include (in no order): \n');

for i=1:length(rIntial)
        shape = 'small';
        if rIntial(i).circularity>circleCircularity
            intial(total,1) = 1;
            intial(total,2) = 1;
            if(rIntial(i).area>locationCircleThreshold)
                shape ='big';
                intial(total,3) = 2;
                for j =1:3
                    if intialOrder(j,2)==i && intialOrder(j,1)==1;
                        intial(total,4)=j;
                    end
                end
            else
                intial(total,3) = 1;
                for j =1:3
                    if intialOrder(j,2)==i && intialOrder(j,1)==1;
                        intial(total,4)=j;
                    end
                end
            end
            fprintf('Red %s circle\n', shape);
            total= total + 1;
        elseif rIntial(i).circularity >squareCircularity
            intial(total,1) = 1;
            intial(total,2) = 2;
            if(rIntial(i).area>locationSquareThreshold)
                shape ='big';
                intial(total,3) = 2;
                for j =1:3
                    if intialOrder(j,2)==i && intialOrder(j,1)==1;
                        intial(total,4)=j;
                    end
                end
            else
                intial(total,3) = 1;
                for j =1:3
                    if intialOrder(j,2)==i && intialOrder(j,1)==1;
                        intial(total,4)=j;
                    end
                end
            end
           fprintf('Red %s square\n', shape);
           total= total + 1;
        elseif rIntial(i).circularity >triangleCircularity
            intial(total,1) = 1;
            intial(total,2) = 3;
            if(rIntial(i).area>locationTriangleThreshold)
                shape ='big';
                intial(total,3) = 2;
                for j =1:3
                    if intialOrder(j,2)==i && intialOrder(j,1)==1;
                        intial(total,4)=j;
                    end
                end
            else
                intial(total,3) = 1;
                for j =1:3
                    if intialOrder(j,2)==i && intialOrder(j,1)==1;
                        intial(total,4)=j;
                    end
                end
            end
            fprintf('Red %s triangle\n', shape);
            total= total + 1;
        end
end

for i=1:length(gIntial)
        shape = 'small';
        if gIntial(i).circularity>circleCircularity
            intial(total,1) = 2;
            intial(total,2) = 1;
            if(gIntial(i).area>locationCircleThreshold)
                shape ='big';
                intial(total,3) = 2;
                for j =1:3
                    if intialOrder(j,2)==i && intialOrder(j,1)==2;
                        intial(total,4)=j;
                    end
                end
            else
                intial(total,3) = 1;
                for j =1:3
                    if intialOrder(j,2)==i && intialOrder(j,1)==2;
                        intial(total,4)=j;
                    end
                end
            end
            fprintf('Green %s circle\n', shape);
            total = total +1;
        elseif gIntial(i).circularity >squareCircularity
            intial(total,1) = 2;
            intial(total,2) = 2;
            if(gIntial(i).area>locationSquareThreshold)
                shape ='big';
                intial(total,3) = 2;
                for j =1:3
                    if intialOrder(j,2)==i && intialOrder(j,1)==2;
                        intial(total,4)=j;
                    end
                end
            else
                intial(total,3) = 1;
                for j =1:3
                    if intialOrder(j,2)==i && intialOrder(j,1)==2;
                        intial(total,4)=j;
                    end
                end
            end
           fprintf('Green %s square\n', shape);
           total = total +1;
        elseif gIntial(i).circularity >triangleCircularity
            intial(total,1) = 2;
            intial(total,2) = 3;
            if(gIntial(i).area>locationTriangleThreshold)
                shape ='big';
                intial(total,3) = 2;
                for j =1:3
                    if intialOrder(j,2)==i && intialOrder(j,1)==2;
                        intial(total,4)=j;
                    end
                end
            else
                intial(total,3) = 1;
                for j =1:3
                    if intialOrder(j,2)==i && intialOrder(j,1)==2;
                        intial(total,4)=j;
                    end
                end
            end
            fprintf('Green %s triangle\n', shape);
            total = total +1;
        end
end

%% Finding the blobs of the final image

imFinal = iread('final1.png');

imNormalFinal = double(imFinal)/255;
imNormalGammaFinal = imNormalFinal.^2.5;
%Seperating image into 3 planes
imRedFinal = imNormalGammaFinal(:,:,1);
imGreenFinal = imNormalGammaFinal(:,:,2);
imBlueFinal = imNormalGammaFinal(:,:,3);
%Getting the chromacity
imbFinal = imBlueFinal./(imRedFinal+imGreenFinal+imBlueFinal);
imrFinal = imRedFinal./(imRedFinal+imGreenFinal+imBlueFinal);
imgFinal = imGreenFinal./(imRedFinal+imGreenFinal+imBlueFinal);
%Getting the blobs
imbThingsFinal = imbFinal>0.5;
imrThingsFinal = imrFinal>0.5;
imgThingsFinal = imgFinal>0.5;

rFinal = iblobs(imrThingsFinal, 'area',[minArea,maxArea],'boundary');
gFinal = iblobs(imgThingsFinal, 'area',[minArea,maxArea],'boundary');

total = 1;

finalOrder = [ 0 0; 0 0; 0 0];

%final order is the order of which the blobs occur
%the first row relates to the first occuring blob
%the second row relates to the second and so on
%the first column says if it is red = 1 or green = 2
%the second column is the blob id

for i=1:length(rFinal)
    if rFinal(i).uc <firstBlobCentroidThreshold
        finalOrder(1,1) = 1;
        finalOrder(1,2) = i;
    elseif rFinal(i).uc >firstBlobCentroidThreshold+1 &&  rFinal(i).uc <secondBlobCentroidThreshold
        finalOrder(2,1) = 1;
        finalOrder(2,2) = i;
    elseif rFinal(i).uc >secondBlobCentroidThreshold+1
        finalOrder(3,1) = 1;
        finalOrder(3,2) = i;
    end
end

for i=1:length(gFinal)
    if  gFinal(i).uc <firstBlobCentroidThreshold
        finalOrder(1,1) = 2;
        finalOrder(1,2) = i;
    elseif gFinal(i).uc >firstBlobCentroidThreshold+1 &&  gFinal(i).uc <secondBlobCentroidThreshold
        finalOrder(2,1) = 2;
        finalOrder(2,2) = i;
    elseif gFinal(i).uc >secondBlobCentroidThreshold+1
        finalOrder(3,1) = 2;
        finalOrder(3,2) = i;
    end
end

fprintf('\nFinal locations include(in no order): \n');

% setting up the final variable
% final goes colour, shape, size, colour is 1 for red, 2 for green
% 1 for circle, 2 for square and 3 for triangle
% 1 for small 2 for large

for i=1:length(rFinal)
        shape = 'small';
        if rFinal(i).circularity>circleCircularity
            final(total,1) = 1;
            final(total,2) = 1;
            if(rFinal(i).area>locationCircleThreshold)
                shape ='big';
                final(total,3) = 2;
                for j =1:3
                    if finalOrder(j,2)==i && finalOrder(j,1)==1;
                        final(total,4)=j;
                    end
                end
            else
                final(total,3) = 1;
                for j =1:3
                    if finalOrder(j,2)==i && finalOrder(j,1)==1;
                        final(total,4)=j;
                    end
                end
            end
            fprintf('Red %s circle\n', shape);
            total= total + 1;
        elseif rFinal(i).circularity >squareCircularity
            final(total,1) = 1;
            final(total,2) = 2;
            if(rFinal(i).area>locationSquareThreshold)
                shape ='big';
                final(total,3) = 2;
                for j =1:3
                    if finalOrder(j,2)==i && finalOrder(j,1)==1;
                        final(total,4)=j;
                    end
                end
            else
                final(total,3) = 1;
                for j =1:3
                    if finalOrder(j,2)==i && finalOrder(j,1)==1;
                        final(total,4)=j;
                    end
                end
            end
           fprintf('Red %s square\n', shape);
           total= total + 1;
        elseif rFinal(i).circularity >triangleCircularity
            final(total,1) = 1;
            final(total,2) = 3;
            if(rFinal(i).area>locationTriangleThreshold)
                shape ='big';
                final(total,3) = 2;
                for j =1:3
                    if finalOrder(j,2)==i && finalOrder(j,1)==1;
                        final(total,4)=j;
                    end
                end
            else
                final(total,3) = 1;
                for j =1:3
                    if finalOrder(j,2)==i && finalOrder(j,1)==1;
                        final(total,4)=j;
                    end
                end
            end
            fprintf('Red %s triangle\n', shape);
            total= total + 1;
        end
end

for i=1:length(gFinal)
        shape = 'small';
        if gFinal(i).circularity>circleCircularity
            final(total,1) = 2;
            final(total,2) = 1;
            if(gFinal(i).area>locationCircleThreshold)
                shape ='big';
                final(total,3) = 2;
                if finalOrder(j,2)==i && finalOrder(j,1)==2;
                        final(total,4)=j;
                end
            else
                final(total,3) = 1;
                if finalOrder(j,2)==i && finalOrder(j,1)==2;
                        final(total,4)=j;
                end
            end
            fprintf('Green %s circle\n', shape);
            total = total +1;
        elseif gFinal(i).circularity >squareCircularity
            final(total,1) = 2;
            final(total,2) = 2;
            if(gFinal(i).area>locationSquareThreshold)
                shape ='big';
                final(total,3) = 2;
                if finalOrder(j,2)==i && finalOrder(j,1)==2;
                        final(total,4)=j;
                end
            else
                final(total,3) = 1;
                if finalOrder(j,2)==i && finalOrder(j,1)==2;
                        final(total,4)=j;
                end
            end
           fprintf('Green %s square\n', shape);
           total = total +1;
        elseif gFinal(i).circularity >triangleCircularity
            final(total,1) = 2;
            final(total,2) = 3;
            if(gFinal(i).area>locationTriangleThreshold)
                shape ='big';
                final(total,3) = 2;
                if finalOrder(j,2)==i && finalOrder(j,1)==2;
                        final(total,4)=j;
                end
            else
                final(total,3) = 1;
                if finalOrder(j,2)==i && finalOrder(j,1)==2;
                        final(total,4)=j;
                end
            end
            fprintf('Green %s triangle\n', shape);
            total = total +1;
        end
end
fprintf('\n')

%% homography of the shapes that need to be found on the layout image

Pb = zeros([2 length(b)]);

for i=1:length(b)
    Pb(1, i) = b(i).uc;
    Pb(2, i) = b(i).vc;
end

% This goes from top left, top middle, top right, halfway right, halfway
% left, halfway middle, bottom left, bottom middle, bottom right.
Q = [345 560; 345 290; 345 20; 182.5 560; 182.5 290; 182.5 20; 20 290; 20 560; 20 20];
H = homography(Pb, Q');

% intial pos relates to the intial blobs image
% first column is red or green 1 for red, 2 for green
% second colum is the blob id on layout image, 3rd column is the X value
% 4th column is the Y value on the layout iamge, 5th column is the order
% that it comes in the iamge
% 6th column is the shape, 1 for circle, 2 for square, 3 for triangle
% 7th column is the shape size 2 for big 1 for small

for i = 1:length(r)
    if(rBound(i)==1)
        continue
    end
    for j =1:size(intial,1)
        if intial(j, 1)==1
            if r(i).circularity>0.9 && intial(j,2)==1
                if r(i).area > circleThreshold && intial(j, 3) == 2
                    p = [r(i).uc r(i).vc];
                    q = homtrans(H, p');
                    intialPos(j, 1)=1;
                    intialPos(j,2) = i;
                    intialPos(j,4) = q(1);
                    intialPos(j,3) = q(2);
                    intialPos(j,5) = intial(j,4);
                    intialPos(j,6) = intial(j,2);
                    intialPos(j,7) = intial(j,3);
                elseif r(i).area < circleThreshold && intial(j,3)==1
                    p = [r(i).uc r(i).vc];
                    q = homtrans(H, p');
                    intialPos(j, 1)=1;
                    intialPos(j,2) = i;
                    intialPos(j,4) = q(1);
                    intialPos(j,3) = q(2);
                    intialPos(j,5) = intial(j,4);
                    intialPos(j,6) = intial(j,2);
                    intialPos(j,7) = intial(j,3);
                end
            elseif r(i).circularity>0.7 && r(i).circularity < 0.9 && intial(j,2)==2
                if r(i).area > squareThreshold && intial(j, 3) == 2
                    p = [r(i).uc r(i).vc];
                    q = homtrans(H, p');
                    intialPos(j, 1)=1;
                    intialPos(j,2) = i;
                    intialPos(j,4) = q(1);
                    intialPos(j,3) = q(2);
                    intialPos(j,5) = intial(j,4);
                    intialPos(j,6) = intial(j,2);
                    intialPos(j,7) = intial(j,3);
                elseif r(i).area < squareThreshold && intial(j,3)==1
                    p = [r(i).uc r(i).vc];
                    q = homtrans(H, p');
                    intialPos(j, 1)=1;
                    intialPos(j,2) = i;
                    intialPos(j,4) = q(1);
                    intialPos(j,3) = q(2);
                    intialPos(j,5) = intial(j,4);
                    intialPos(j,6) = intial(j,2);
                    intialPos(j,7) = intial(j,3);
                end
            elseif r(i).circularity>0.55 && r(i).circularity < 0.7 && intial(j,2)==3
                if r(i).area > triangleThreshold && intial(j, 3) == 2
                    p = [r(i).uc r(i).vc];
                    q = homtrans(H, p');
                    intialPos(j, 1)=1;
                    intialPos(j,2) = i;
                    intialPos(j,4) = q(1);
                    intialPos(j,3) = q(2);
                    intialPos(j,5) = intial(j,4);
                    intialPos(j,6) = intial(j,2);
                    intialPos(j,7) = intial(j,3);
                elseif r(i).area < triangleThreshold && intial(j,3)==1
                    p = [r(i).uc r(i).vc];
                    q = homtrans(H, p');
                    intialPos(j, 1)=1;
                    intialPos(j,2) = i;
                    intialPos(j,4) = q(1);
                    intialPos(j,3) = q(2);
                    intialPos(j,5) = intial(j,4);
                    intialPos(j,6) = intial(j,2);
                    intialPos(j,7) = intial(j,3);
                end
            end
        end
    end
end


for i = 1:length(g)
    if(gBound(i)==1)
        continue
    end
    for j =1:size(intial,1)
        if intial(j, 1)==2
            if g(i).circularity>0.9 && intial(j,2)==1
                if g(i).area > circleThreshold && intial(j, 3) == 2
                    p = [g(i).uc g(i).vc];
                    q = homtrans(H, p');
                    intialPos(j, 1)=2;
                    intialPos(j,2) = i;
                    intialPos(j,4) = q(1);
                    intialPos(j,3) = q(2);
                    intialPos(j,5) = intial(j,4);
                    intialPos(j,6) = intial(j,2);
                    intialPos(j,7) = intial(j,3);
                elseif g(i).area < circleThreshold && intial(j,3)==1
                    p = [g(i).uc g(i).vc];
                    q = homtrans(H, p');
                    intialPos(j, 1)=2;
                    intialPos(j,2) = i;
                    intialPos(j,4) = q(1);
                    intialPos(j,3) = q(2);
                    intialPos(j,5) = intial(j,4);
                    intialPos(j,6) = intial(j,2);
                    intialPos(j,7) = intial(j,3);
                end
            elseif g(i).circularity>0.7 && g(i).circularity < 0.9 && intial(j,2)==2
                if g(i).area > squareThreshold && intial(j, 3) == 2
                    p = [g(i).uc g(i).vc];
                    q = homtrans(H, p');
                    intialPos(j, 1)=2;
                    intialPos(j,2) = i;
                    intialPos(j,4) = q(1);
                    intialPos(j,3) = q(2);
                    intialPos(j,5) = intial(j,4);
                    intialPos(j,6) = intial(j,2);
                    intialPos(j,7) = intial(j,3);
                elseif g(i).area < squareThreshold && intial(j,3)==1
                    p = [g(i).uc g(i).vc];
                    q = homtrans(H, p');
                    intialPos(j, 1)=2;
                    intialPos(j,2) = i;
                    intialPos(j,4) = q(1);
                    intialPos(j,3) = q(2);
                    intialPos(j,5) = intial(j,4);
                    intialPos(j,6) = intial(j,2);
                    intialPos(j,7) = intial(j,3);
                end
            elseif g(i).circularity>0.55 && g(i).circularity < 0.7 && intial(j,2)==3
                if g(i).area > triangleThreshold && intial(j, 3) == 2
                    p = [g(i).uc g(i).vc];
                    q = homtrans(H, p');
                    intialPos(j, 1)=2;
                    intialPos(j,2) = i;
                    intialPos(j,4) = q(1);
                    intialPos(j,3) = q(2);
                    intialPos(j,5) = intial(j,4);
                    intialPos(j,6) = intial(j,2);
                    intialPos(j,7) = intial(j,3);
                elseif g(i).area < triangleThreshold && intial(j,3)==1
                    p = [g(i).uc g(i).vc];
                    q = homtrans(H, p');
                    intialPos(j, 1)=2;
                    intialPos(j,2) = i;
                    intialPos(j,4) = q(1);
                    intialPos(j,3) = q(2);
                    intialPos(j,5) = intial(j,4);
                    intialPos(j,6) = intial(j,2);
                    intialPos(j,7) = intial(j,3);
                end
            end
        end
    end
end

% final pos relates to the intial blobs image
% first column is red or green 1 for red, 2 for green
% second colum is the blob id on layout image, 3rd column is the Y value
% 4th column is the x value on the layout iamge, 5th column is the order
% that it comes in the iamge
% 6th column is the shape, 1 for circle, 2 for square, 3 for triangle
% 7th column is the shape size 2 for big 1 for small


for i = 1:length(r)
    if(rBound(i)==1)
        continue
    end
    for j =1:size(final,1)
        if final(j, 1)==1
            if r(i).circularity>0.9 && final(j,2)==1
                if r(i).area > circleThreshold && final(j, 3) == 2
                    p = [r(i).uc r(i).vc];
                    q = homtrans(H, p');
                    finalPos(j, 1)=1;
                    finalPos(j,2) = i;
                    finalPos(j,4) = q(1);
                    finalPos(j,3) = q(2);
                    finalPos(j,5) = final(j,4);
                    finalPos(j,6) = final(j,2);
                    finalPos(j,7) = final(j,3);
                elseif r(i).area < circleThreshold && final(j,3)==1
                    p = [r(i).uc r(i).vc];
                    q = homtrans(H, p');
                    finalPos(j, 1)=1;
                    finalPos(j,2) = i;
                    finalPos(j,4) = q(1);
                    finalPos(j,3) = q(2);
                    finalPos(j,5) = final(j,4);
                    finalPos(j,6) = final(j,2);
                    finalPos(j,7) = final(j,3);
                end
            elseif r(i).circularity>0.7 && r(i).circularity < 0.9 && final(j,2)==2
                if r(i).area > squareThreshold && final(j, 3) == 2
                    p = [r(i).uc r(i).vc];
                    q = homtrans(H, p');
                    finalPos(j, 1)=1;
                    finalPos(j,2) = i;
                    finalPos(j,4) = q(1);
                    finalPos(j,3) = q(2);
                    finalPos(j,5) = final(j,4);
                    finalPos(j,6) = final(j,2);
                    finalPos(j,7) = final(j,3);
                elseif r(i).area < squareThreshold && final(j,3)==1
                    p = [r(i).uc r(i).vc];
                    q = homtrans(H, p');
                    finalPos(j, 1)=1;
                    finalPos(j,2) = i;
                    finalPos(j,4) = q(1);
                    finalPos(j,3) = q(2);
                    finalPos(j,5) = final(j,4);
                    finalPos(j,6) = final(j,2);
                    finalPos(j,7) = final(j,3);
                end
            elseif r(i).circularity>0.55 && r(i).circularity < 0.7 && final(j,2)==3
                if r(i).area > triangleThreshold && final(j, 3) == 2
                    p = [r(i).uc r(i).vc];
                    q = homtrans(H, p');
                    finalPos(j, 1)=1;
                    finalPos(j,2) = i;
                    finalPos(j,4) = q(1);
                    finalPos(j,3) = q(2);
                    finalPos(j,5) = final(j,4);
                    finalPos(j,6) = final(j,2);
                    finalPos(j,7) = final(j,3);
                elseif r(i).area < triangleThreshold && final(j,3)==1
                    p = [r(i).uc r(i).vc];
                    q = homtrans(H, p');
                    finalPos(j, 1)=1;
                    finalPos(j,2) = i;
                    finalPos(j,4) = q(1);
                    finalPos(j,3) = q(2);
                    finalPos(j,5) = final(j,4);
                    finalPos(j,6) = final(j,2);
                    finalPos(j,7) = final(j,3);
                end
            end
        end
    end
end

for i = 1:length(g)
    if(gBound(i)==1)
        continue
    end
    for j =1:size(final,1)
        if final(j, 1)==2
            if g(i).circularity>0.9 && final(j,2)==1
                if g(i).area > circleThreshold && final(j, 3) == 2
                    p = [g(i).uc g(i).vc];
                    q = homtrans(H, p');
                    finalPos(j, 1)=2;
                    finalPos(j,2) = i;
                    finalPos(j,4) = q(1);
                    finalPos(j,3) = q(2);
                    finalPos(j,5) = final(j,4);
                    finalPos(j,6) = final(j,2);
                    finalPos(j,7) = final(j,3);
                elseif g(i).area < circleThreshold && intial(j,3)==1
                    p = [g(i).uc g(i).vc];
                    q = homtrans(H, p');
                    finalPos(j, 1)=2;
                    finalPos(j,2) = i;
                    finalPos(j,4) = q(1);
                    finalPos(j,3) = q(2);
                    finalPos(j,5) = final(j,4);
                    finalPos(j,6) = final(j,2);
                    finalPos(j,7) = final(j,3);
                end
            elseif g(i).circularity>0.7 && g(i).circularity < 0.9 && final(j,2)==2
                if g(i).area > squareThreshold && final(j, 3) == 2
                    p = [g(i).uc g(i).vc];
                    q = homtrans(H, p');
                    finalPos(j, 1)=2;
                    finalPos(j,2) = i;
                    finalPos(j,4) = q(1);
                    finalPos(j,3) = q(2);
                    finalPos(j,5) = final(j,4);
                    finalPos(j,6) = final(j,2);
                    finalPos(j,7) = final(j,3);
                elseif g(i).area < squareThreshold && final(j,3)==1
                    p = [g(i).uc g(i).vc];
                    q = homtrans(H, p');
                    finalPos(j, 1)=2;
                    finalPos(j,2) = i;
                    finalPos(j,4) = q(1);
                    finalPos(j,3) = q(2);
                    finalPos(j,5) = final(j,4);
                    finalPos(j,6) = final(j,2);
                    finalPos(j,7) = final(j,3);
                end
            elseif g(i).circularity>0.55 && g(i).circularity < 0.7 && final(j,2)==3
                if g(i).area > triangleThreshold && final(j, 3) == 2
                    p = [g(i).uc g(i).vc];
                    q = homtrans(H, p');
                    finalPos(j, 1)=2;
                    finalPos(j,2) = i;
                    finalPos(j,4) = q(1);
                    finalPos(j,3) = q(2);
                    finalPos(j,5) = final(j,4);
                    finalPos(j,6) = final(j,2);
                    finalPos(j,7) = final(j,3);
                elseif g(i).area < triangleThreshold && final(j,3)==1
                    p = [g(i).uc g(i).vc];
                    q = homtrans(H, p');
                    finalPos(j, 1)=2;
                    finalPos(j,2) = i;
                    finalPos(j,4) = q(1);
                    finalPos(j,3) = q(2);
                    finalPos(j,5) = final(j,4);
                    finalPos(j,6) = final(j,2);
                    finalPos(j,7) = final(j,3);
                end
            end
        end
    end
end

%% Finally saying where the cylinders are and where they need to go and what order

for i = 1:3
    fprintf('\nMove %d \n', i);
    for j = 1:3
        if intialPos(j,5)==i
            if intialPos(j,1)==1
                if intialPos(j,6)==1
                    if intialPos(j,7) ==1
                        tempIntialLocation = [intialPos(j,4)-armLocation(1), intialPos(j,3)-armLocation(2)];
                        if intialPos(j,4) < armLocation(1) && intialPos(j,3) > armLocation(2)
                            if tempIntialLocation(1) > 0 && tempIntialLocation(2) < 0
                                tempIntialLocation(1) = tempIntialLocation(1)- tempIntialLocation(1)*2;
                                tempIntialLocation(2) = tempIntialLocation(2)- tempIntialLocation(2)*2;
                            end
                        end
                        fprintf('Need to move the cylinder at on the small, red circle at X: %dmm Y: %dmm to\n', intialPos(j,4), intialPos(j,3));
                    elseif intialPos(j,7)==2
                        tempIntialLocation = [intialPos(j,4)-armLocation(1), intialPos(j,3)-armLocation(2)];
                        if intialPos(j,4) < armLocation(1) && intialPos(j,3) > armLocation(2)
                            if tempIntialLocation(1) > 0 && tempIntialLocation(2) < 0
                                tempIntialLocation(1) = tempIntialLocation(1)- tempIntialLocation(1)*2;
                                tempIntialLocation(2) = tempIntialLocation(2)- tempIntialLocation(2)*2;
                            end
                        end
                        fprintf('Need to move the cylinder at on the big, red circle at X: %dmm Y: %dmm to\n', intialPos(j,4), intialPos(j,3));
                    end
                elseif intialPos(j,6)==2
                    if intialPos(j,7) ==1
                       tempIntialLocation = [intialPos(j,4)-armLocation(1), intialPos(j,3)-armLocation(2)];
                       if intialPos(j,4) < armLocation(1) && intialPos(j,3) > armLocation(2)
                            if tempIntialLocation(1) > 0 && tempIntialLocation(2) < 0
                                tempIntialLocation(1) = tempIntialLocation(1)- tempIntialLocation(1)*2;
                                tempIntialLocation(2) = tempIntialLocation(2)- tempIntialLocation(2)*2;
                            end
                        end
                        fprintf('Need to move the cylinder at on the small, red square at X: %dmm Y: %dmm to\n', intialPos(j,4), intialPos(j,3));
                    elseif intialPos(j,7)==2
                        tempIntialLocation = [intialPos(j,4)-armLocation(1), intialPos(j,3)-armLocation(2)];
                        if intialPos(j,4) < armLocation(1) && intialPos(j,3) > armLocation(2)
                            if tempIntialLocation(1) > 0 && tempIntialLocation(2) < 0
                                tempIntialLocation(1) = tempIntialLocation(1)- tempIntialLocation(1)*2;
                                tempIntialLocation(2) = tempIntialLocation(2)- tempIntialLocation(2)*2;
                            end
                        end
                        fprintf('Need to move the cylinder at on the big, red square at X: %dmm Y: %dmm to\n', intialPos(j,4), intialPos(j,3));
                    end
                elseif intialPos(j,6) ==3
                     if intialPos(j,7) ==1
                        tempIntialLocation = [intialPos(j,4)-armLocation(1), intialPos(j,3)-armLocation(2)];
                        if intialPos(j,4) < armLocation(1) && intialPos(j,3) > armLocation(2)
                            if tempIntialLocation(1) > 0 && tempIntialLocation(2) < 0
                                tempIntialLocation(1) = tempIntialLocation(1)- tempIntialLocation(1)*2;
                                tempIntialLocation(2) = tempIntialLocation(2)- tempIntialLocation(2)*2;
                            end
                        end
                        fprintf('Need to move the cylinder at on the small, red triangle at X: %dmm Y: %dmm to\n', intialPos(j,4), intialPos(j,3));
                    elseif intialPos(j,7)==2
                        tempIntialLocation = [intialPos(j,4)-armLocation(1), intialPos(j,3)-armLocation(2)];
                        if intialPos(j,4) < armLocation(1) && intialPos(j,3) > armLocation(2)
                            if tempIntialLocation(1) > 0 && tempIntialLocation(2) < 0
                                tempIntialLocation(1) = tempIntialLocation(1)- tempIntialLocation(1)*2;
                                tempIntialLocation(2) = tempIntialLocation(2)- tempIntialLocation(2)*2;
                            end
                        end
                        fprintf('Need to move the cylinder at on the big, red triangle at X: %dmm Y: %dmm to\n', intialPos(j,4), intialPos(j,3));
                     end
                end
            elseif intialPos(j,1)==2
                   if intialPos(j,6)==1
                    if intialPos(j,7) ==1
                       tempIntialLocation = [intialPos(j,4)-armLocation(1), intialPos(j,3)-armLocation(2)];
                       if intialPos(j,4) < armLocation(1) && intialPos(j,3) > armLocation(2)
                            if tempIntialLocation(1) > 0 && tempIntialLocation(2) < 0
                                tempIntialLocation(1) = tempIntialLocation(1)- tempIntialLocation(1)*2;
                                tempIntialLocation(2) = tempIntialLocation(2)- tempIntialLocation(2)*2;
                            end
                        end
                        fprintf('Need to move the cylinder at on the small, green circle at X: %dmm Y: %dmm to\n', intialPos(j,4), intialPos(j,3));
                    elseif intialPos(j,7)==2
                        tempIntialLocation = [intialPos(j,4)-armLocation(1), intialPos(j,3)-armLocation(2)];
                        if intialPos(j,4) < armLocation(1) && intialPos(j,3) > armLocation(2)
                            if tempIntialLocation(1) > 0 && tempIntialLocation(2) < 0
                                tempIntialLocation(1) = tempIntialLocation(1)- tempIntialLocation(1)*2;
                                tempIntialLocation(2) = tempIntialLocation(2)- tempIntialLocation(2)*2;
                            end
                        end
                        fprintf('Need to move the cylinder at on the big, green circle at X: %dmm Y: %dmm to\n', intialPos(j,4), intialPos(j,3));
                    end
                elseif intialPos(j,6)==2
                    if intialPos(j,7) ==1
                        tempIntialLocation = [intialPos(j,4)-armLocation(1), intialPos(j,3)-armLocation(2)];
                        if intialPos(j,4) < armLocation(1) && intialPos(j,3) > armLocation(2)
                            if tempIntialLocation(1) > 0 && tempIntialLocation(2) < 0
                                tempIntialLocation(1) = tempIntialLocation(1)- tempIntialLocation(1)*2;
                                tempIntialLocation(2) = tempIntialLocation(2)- tempIntialLocation(2)*2;
                            end
                        end
                        fprintf('Need to move the cylinder at on the small, green square at X: %dmm Y: %dmm to\n', intialPos(j,4), intialPos(j,3));
                    elseif intialPos(j,7)==2
                        tempIntialLocation = [intialPos(j,4)-armLocation(1), intialPos(j,3)-armLocation(2)];
                        if intialPos(j,4) < armLocation(1) && intialPos(j,3) > armLocation(2)
                            if tempIntialLocation(1) > 0 && tempIntialLocation(2) < 0
                                tempIntialLocation(1) = tempIntialLocation(1)- tempIntialLocation(1)*2;
                                tempIntialLocation(2) = tempIntialLocation(2)- tempIntialLocation(2)*2;
                            end
                        end
                        fprintf('Need to move the cylinder at on the big, green square at X: %dmm Y: %dmm to\n', intialPos(j,4), intialPos(j,3));
                    end
                elseif intialPos(j,6) ==3
                     if intialPos(j,7) ==1
                        tempIntialLocation = [intialPos(j,4)-armLocation(1), intialPos(j,3)-armLocation(2)];
                        if intialPos(j,4) < armLocation(1) && intialPos(j,3) > armLocation(2)
                            if tempIntialLocation(1) > 0 && tempIntialLocation(2) < 0
                                tempIntialLocation(1) = tempIntialLocation(1)- tempIntialLocation(1)*2;
                                tempIntialLocation(2) = tempIntialLocation(2)- tempIntialLocation(2)*2;
                            end
                        end
                        fprintf('Need to move the cylinder at on the small, green triangle at X: %dmm Y: %dmm to\n', intialPos(j,4), intialPos(j,3));
                    elseif intialPos(j,7)==2
                        tempIntialLocation = [intialPos(j,4)-armLocation(1), intialPos(j,3)-armLocation(2)];
                        if intialPos(j,4) < armLocation(1) && intialPos(j,3) > armLocation(2)
                            if tempIntialLocation(1) > 0 && tempIntialLocation(2) < 0
                                tempIntialLocation(1) = tempIntialLocation(1)- tempIntialLocation(1)*2;
                                tempIntialLocation(2) = tempIntialLocation(2)- tempIntialLocation(2)*2;
                            end
                        end
                        fprintf('Need to move the cylinder at on the big, green triangle at X: %dmm Y: %dmm to\n', intialPos(j,4), intialPos(j,3));
                     end
                 end
            end
        end
    end
    
    %final position
    
    for j = 1:3
        if finalPos(j,5)==i
            if finalPos(j,1)==1
                if finalPos(j,6)==1
                    if finalPos(j,7) ==1
                        tempFinalLocation = [finalPos(j,4)-armLocation(1), finalPos(j,3)-armLocation(2)];
                        if finalPos(j,4) < armLocation(1) && finalPos(j,3) > armLocation(2)
                            if tempFinalLocation(1) > 0 && tempFinalLocation(2) < 0
                                tempFinalLocation(1) = tempFinalLocation(1)- tempFinalLocation(1)*2;
                                tempFinalLocation(2) = tempFinalLocation(2)- tempFinalLocation(2)*2;
                            end
                        end
                        fprintf('the small, red circle at X: %dmm Y: %dmm\n', finalPos(j,4), finalPos(j,3));
                    elseif finalPos(j,7)==2
                        tempFinalLocation = [finalPos(j,4)-armLocation(1), finalPos(j,3)-armLocation(2)];
                        if finalPos(j,4) < armLocation(1) && finalPos(j,3) > armLocation(2)
                            if tempFinalLocation(1) > 0 && tempFinalLocation(2) < 0
                                tempFinalLocation(1) = tempFinalLocation(1)- tempFinalLocation(1)*2;
                                tempFinalLocation(2) = tempFinalLocation(2)- tempFinalLocation(2)*2;
                            end
                        end
                        fprintf('the big, red circle at X: %dmm Y: %dmm\n', finalPos(j,4), finalPos(j,3));
                    end
                elseif finalPos(j,6)==2
                    if finalPos(j,7) ==1
                        tempFinalLocation = [finalPos(j,4)-armLocation(1), finalPos(j,3)-armLocation(2)];
                        if finalPos(j,4) < armLocation(1) && finalPos(j,3) > armLocation(2)
                            if tempFinalLocation(1) > 0 && tempFinalLocation(2) < 0
                                tempFinalLocation(1) = tempFinalLocation(1)- tempFinalLocation(1)*2;
                                tempFinalLocation(2) = tempFinalLocation(2)- tempFinalLocation(2)*2;
                            end
                        end
                        fprintf('the small, red square at X: %dmm Y: %dmm\n', finalPos(j,4), finalPos(j,3));
                    elseif finalPos(j,7)==2
                        tempFinalLocation = [finalPos(j,4)-armLocation(1), finalPos(j,3)-armLocation(2)];
                        if finalPos(j,4) < armLocation(1) && finalPos(j,3) > armLocation(2)
                            if tempFinalLocation(1) > 0 && tempFinalLocation(2) < 0
                                tempFinalLocation(1) = tempFinalLocation(1)- tempFinalLocation(1)*2;
                                tempFinalLocation(2) = tempFinalLocation(2)- tempFinalLocation(2)*2;
                            end
                        end
                        fprintf('the big, red square at X: %dmm Y: %dmm\n', finalPos(j,4), finalPos(j,3));
                    end
                elseif finalPos(j,6) ==3
                     if finalPos(j,7) ==1
                        tempFinalLocation = [finalPos(j,4)-armLocation(1), finalPos(j,3)-armLocation(2)];
                        if finalPos(j,4) < armLocation(1) && finalPos(j,3) > armLocation(2)
                            if tempFinalLocation(1) > 0 && tempFinalLocation(2) < 0
                                tempFinalLocation(1) = tempFinalLocation(1)- tempFinalLocation(1)*2;
                                tempFinalLocation(2) = tempFinalLocation(2)- tempFinalLocation(2)*2;
                            end
                        end
                        fprintf('the small, red triangle at X: %dmm Y: %dmm\n', finalPos(j,4), finalPos(j,3));
                    elseif finalPos(j,7)==2
                        tempFinalLocation = [finalPos(j,4)-armLocation(1), finalPos(j,3)-armLocation(2)];
                        if finalPos(j,4) < armLocation(1) && finalPos(j,3) > armLocation(2)
                            if tempFinalLocation(1) > 0 && tempFinalLocation(2) < 0
                                tempFinalLocation(1) = tempFinalLocation(1)- tempFinalLocation(1)*2;
                                tempFinalLocation(2) = tempFinalLocation(2)- tempFinalLocation(2)*2;
                            end
                        end
                        fprintf('the big, red triangle at X: %dmm Y: %dmm\n', finalPos(j,4), finalPos(j,3));
                     end
                end
            elseif finalPos(j,1)==2
                   if finalPos(j,6)==1
                    if finalPos(j,7) ==1
                        tempFinalLocation = [finalPos(j,4)-armLocation(1), finalPos(j,3)-armLocation(2)];
                        if finalPos(j,4) < armLocation(1) && finalPos(j,3) > armLocation(2)
                            if tempFinalLocation(1) > 0 && tempFinalLocation(2) < 0
                                tempFinalLocation(1) = tempFinalLocation(1)- tempFinalLocation(1)*2;
                                tempFinalLocation(2) = tempFinalLocation(2)- tempFinalLocation(2)*2;
                            end
                        end
                        fprintf('the small, green circle at X: %dmm Y: %dmm\n', finalPos(j,4), finalPos(j,3));
                    elseif finalPos(j,7)==2
                        tempFinalLocation = [finalPos(j,4)-armLocation(1), finalPos(j,3)-armLocation(2)];
                         if finalPos(j,4) < armLocation(1) && finalPos(j,3) > armLocation(2)
                            if tempFinalLocation(1) > 0 && tempFinalLocation(2) < 0
                                tempFinalLocation(1) = tempFinalLocation(1)- tempFinalLocation(1)*2;
                                tempFinalLocation(2) = tempFinalLocation(2)- tempFinalLocation(2)*2;
                            end
                        end
                        fprintf('the big, green circle at X: %dmm Y: %dmm\n', finalPos(j,4), finalPos(j,3));
                    end
                elseif finalPos(j,6)==2
                    if finalPos(j,7) ==1
                        tempFinalLocation = [finalPos(j,4)-armLocation(1), finalPos(j,3)-armLocation(2)];
                        if finalPos(j,4) < armLocation(1) && finalPos(j,3) > armLocation(2)
                            if tempFinalLocation(1) > 0 && tempFinalLocation(2) < 0
                                tempFinalLocation(1) = tempFinalLocation(1)- tempFinalLocation(1)*2;
                                tempFinalLocation(2) = tempFinalLocation(2)- tempFinalLocation(2)*2;
                            end
                        end
                        fprintf('the small, green square at X: %dmm Y: %dmm\n', finalPos(j,4), finalPos(j,3));
                    elseif finalPos(j,7)==2
                        tempFinalLocation = [finalPos(j,4)-armLocation(1), finalPos(j,3)-armLocation(2)];
                        if finalPos(j,4) < armLocation(1) && finalPos(j,3) > armLocation(2)
                            if tempFinalLocation(1) > 0 && tempFinalLocation(2) < 0
                                tempFinalLocation(1) = tempFinalLocation(1)- tempFinalLocation(1)*2;
                                tempFinalLocation(2) = tempFinalLocation(2)- tempFinalLocation(2)*2;
                            end
                        end
                        fprintf('the big, green square at X: %dmm Y: %dmm\n', finalPos(j,4), finalPos(j,3));
                    end
                elseif finalPos(j,6) ==3
                     if finalPos(j,7) ==1
                        tempFinalLocation = [finalPos(j,4)-armLocation(1), finalPos(j,3)-armLocation(2)];
                        if finalPos(j,4) < armLocation(1) && finalPos(j,3) > armLocation(2)
                            if tempFinalLocation(1) > 0 && tempFinalLocation(2) < 0
                                tempFinalLocation(1) = tempFinalLocation(1)- tempFinalLocation(1)*2;
                                tempFinalLocation(2) = tempFinalLocation(2)- tempFinalLocation(2)*2;
                            end
                        end
                        fprintf('the small, green triangle at X: %dmm Y: %dmm\n', finalPos(j,4), finalPos(j,3));
                    elseif finalPos(j,7)==2
                        tempFinalLocation = [finalPos(j,4)-armLocation(1), finalPos(j,3)-armLocation(2)];
                        if finalPos(j,4) < armLocation(1) && finalPos(j,3) > armLocation(2)
                            if tempFinalLocation(1) > 0 && tempFinalLocation(2) < 0
                                tempFinalLocation(1) = tempFinalLocation(1)- tempFinalLocation(1)*2;
                                tempFinalLocation(2) = tempFinalLocation(2)- tempFinalLocation(2)*2;
                            end
                        end
                        fprintf('the big, green triangle at X: %dmm Y: %dmm\n', finalPos(j,4), finalPos(j,3));
                     end
                 end
            end
        end
    end
    fprintf('\nThis means from the arms(0,0) position it needs to move the cylinder at X: %dmm Y: %dmm to\n', tempIntialLocation(1),tempIntialLocation(2));
    fprintf('The shape located at X: %dmm Y: %dmm from the arms final positons\n', tempFinalLocation(1),tempFinalLocation(2));
end

if debugMode == 1
    figure(1)
    imshow(imbThings)
    title('layout Blue Blobs');
    figure(2)
    imshow(imrThings)
    title('layout Red Blobs');
    figure(3)
    imshow(imgThings)
    title('layout Green Blobs');
    figure(4)
    imshow(imrThingsIntial)
    title('intial Red Blobs');
    figure(5)
    imshow(imgThingsIntial)
    title('intial Green Blobs');
    figure(6)
    imshow(imrThingsFinal)
    title('final Red Blobs');
    figure(7)
    imshow(imgThingsFinal)
    title('final Green Blobs');
    figure(8)
    imshow(im)
    title('layout input image');
    figure(9)
    imshow(imIntial)
    title('intial input image');
    figure(10)
    imshow(imFinal)
    title('final input image');
    fprintf('\nDEBUG MODE OUTPUT \n');
    fprintf('Layout Blobs Blue\n');
    b
    fprintf('\nLayout Blobs Red')
    r
    fprintf('\nLayout Blobs Green')
    g
    fprintf('\nIntial location Blobs Red')
    rIntial
    fprintf('\nIntial location Blobs Green')
    gIntial
    fprintf('\nFinal location Blobs Red')
    rFinal
    fprintf('\nFinal location Blobs Green')
    gFinal
    fprintf('\nIntial location Blobs matrix')
    intial
    fprintf('\nFinal location Blobs matrix')
    final
    fprintf('\nIntial location Blobs order matrix')
    intialOrder
    fprintf('\nFinal location Blobs order matrix')
    finalOrder
    fprintf('\nIntial location Blobs matrix with homography')
    intialPos
    fprintf('\nFinal location Blobs matrix with homography')
    finalPos
end

