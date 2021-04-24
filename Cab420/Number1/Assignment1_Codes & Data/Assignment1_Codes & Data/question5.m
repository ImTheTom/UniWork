%% Clear workspace and command window
clc; clear all; close all;

%% Load and setup data
iris=load('data/iris.txt');
X = iris(:,1:2); Y=iris(:,end);
[X, Y] = shuffleData(X,Y);
X = rescale(X);
XA = X(Y<2,:); YA=Y(Y<2);
XB = X(Y>0,:); YB=Y(Y>0);

XAClass0 = XA(find(YA==0),:);
XAClass1 = XA(find(YA==1),:);
XBClass1 = XB(find(YB==1),:);
XBClass2 = XB(find(YB==2),:);

%% a) Plotting data
figure;
hold on
plot(XAClass0(:,1),XAClass0(:,2), 'bo')
plot(XAClass1(:,1),XAClass1(:,2), 'ro')
hold off
title('Sepel lengths and widths of different Iris')
ylabel('sepel width(cm)')
xlabel('sepel length(cm)')
legend('Setosa','Versicolour')

figure;
hold on
plot(XBClass1(:,1),XBClass1(:,2), 'bo')
plot(XBClass2(:,1),XBClass2(:,2), 'ro')
hold off
title('Sepel lengths and widths of different Iris')
ylabel('sepel width(cm)')
xlabel('sepel length(cm)')
legend('Versicolour', 'Virginica')

pause;
%% b) Adding a line
learner = logisticClassify2();
learner=setClasses(learner, unique(YA));
wts = [.5 1 -.25]; %sign(0.5+1x1-0.25x2)
learner=setWeights(learner, wts);

figure;
plot2DLinear(learner,XA,YA);
title('Sepel lengths and widths of different Iris with linear line')
ylabel('sepel width(cm)')
xlabel('sepel length(cm)')

figure;
plot2DLinear(learner,XB,YB);
title('Sepel lengths and widths of different Iris with linear line')
ylabel('sepel width(cm)')
xlabel('sepel length(cm)')

pause;
%% c) Making predict
errorRateA = err(learner,XA,YA)

errorRateB = err(learner,XB,YB)

pause;
%% f) Train
[XA, YA] = shuffleData(XA,YA);
train(learner,XA, YA, 'reg', 0, 'stopiter', 50, 'stepsize', 1, 'stoptol',0.0005);
figure;
plotClassify2D(learner,XA, YA);
title('Sepel lengths and widths of different Iris logistic regression classifier')
ylabel('sepel width(cm)')
xlabel('sepel length(cm)')
legend('Setosa','Versicolour')

pause;

[XB, YB] = shuffleData(XB, YB);
train(learner,XB, YB, 'reg', 0, 'stopiter', 50, 'stepsize', 1, 'stoptol',0.0005);
figure;
plotClassify2D(learner,XB, YB);
title('Sepel lengths and widths of different Iris logistic regression classifier')
ylabel('sepel width(cm)')
xlabel('sepel length(cm)')
legend('Versicolour', 'Virginica')