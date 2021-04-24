%% Clear workspace and command window
clc; clear all; close all;

%% a) Plotting the data
mTrain = load('data/mcycleTrain.txt');
ytr = mTrain(:,1);
xtr = mTrain(:,2);

figure(1)
scatter(xtr,ytr,20,'bo');
title('McycleTrain data')
ylabel('First Column')
xlabel('Second Column')

pause;
%% b) Creating linear predictor
Xtr = [ones(size(xtr,1),1),xtr]; %Allow for intercept and slope to be calculated
learner = linearReg(Xtr, ytr); % create learner

xline = [0:.01:2]';
yline=predict(learner, polyx(xline,1)); %create y values for the line

hold on
plot(xline,yline,'r');
title('Linear predictor on mycycleTrain data');
legend('actual value','predicited value');

pause;
%% c) Linear predictor for fifth-degree polynomial
figure(2)
plot(xtr,ytr,'bo');

XtrPoly = [ones(size(xtr,1),1),xtr,xtr.^2,xtr.^3,xtr.^4,xtr.^5]; %Set up the X variable
learnerPoly = linearReg(XtrPoly, ytr);

xlinePoly = [0:.01:2]';
ylinePoly=predict(learnerPoly, polyx(xlinePoly,5)); 

hold on
plot(xlinePoly,ylinePoly,'r');
legend('actual value','predicited value');
title('Fifth degree polynomial predictor on data');
ylabel('First Column')
xlabel('Second Column')
axis([0 2 -150 100])

pause;
%% d) Mean squared error
yhat = predict(learner, Xtr); % predict values
m=size(xtr,1);
MSETrain = 0;
for i=1:m
    MSETrain = MSETrain + (ytr(i)-yhat(i))^2;
end
MSETrain = MSETrain/m

yhatPoly = predict(learnerPoly, XtrPoly);
MSEPolyTrain=0;
for i=1:m
    MSEPolyTrain = MSEPolyTrain + (ytr(i)-yhatPoly(i))^2;
end
MSEPolyTrain = MSEPolyTrain/m

pause;
%% e) Mean squared error for test data
mTest = load('data/mcycleTest.txt');
yte = mTest(:,1);
xte = mTest(:,2);

Xte = [ones(size(xte,1),1),xte];
MSETest = mse(learner, Xte, yte)

XtePoly = [ones(size(xte,1),1),xte,xte.^2,xte.^3,xte.^4,xte.^5];
MSEPolyTest = mse(learnerPoly, XtePoly, yte)