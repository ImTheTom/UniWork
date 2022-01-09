%% Clear workspace and command window
clc; clear all; close all;

%% Load in and setup data
mTrain = load('data/mcycleTrain.txt');

ytr = mTrain(:,1);
xtr = mTrain(:,2);

%% b) Affect of k on kNN regression

k = [1 2 3 5 10 50]; % k value vector
for i=1:length(k)
    learner = knnRegress(k(i),xtr,ytr); % create learner
    prediction = predict(learner,xtr); % predict values
    
    figure(i)
    plot(xtr,prediction,'bo')
    title(['mcycleTrain Data with kNN regression k value ' num2str(k(i))])
    ylabel('First Column of mcycleTrain')
    xlabel('Second Column of mcycleTrain')
end