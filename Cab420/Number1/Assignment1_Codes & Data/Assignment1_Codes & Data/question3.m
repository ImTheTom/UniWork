%% Clear workspace and command window
clc; clear all; close all;

%% Load in and setup data
mTrain = load('data/mcycleTrain.txt');

ytr = mTrain(:,1);
xtr = mTrain(:,2);

xtrInitial = xtr(1:20); %setting variables to the first 20 x and y values
ytrInitial = ytr(1:20); 

%% a) k values versus mean squared error on 20 data points
k = [1:100]; % vector containing numbers 1 to 100 for the k value
MeanSquaredErrorsInitial = []; %vector containing mean squared error values
for i=1:length(k)
    learner = knnRegress(k(i),xtrInitial,ytrInitial); % train learner
    prediction = predict(learner,xtrInitial); % test learner
    
    MSE = mean( (prediction-ytrInitial).^2 ); % caclulate error
    MeanSquaredErrorsInitial = [MeanSquaredErrorsInitial, MSE]; % append new value to end
end
figure(1)
loglog(k,MeanSquaredErrorsInitial)
title('k value versus mean squared error on 20 data points')
ylabel('Mean square error')
xlabel('K Value')

pause;
%% b) k values versus mean squared error all data
k = [1:100];
MeanSquaredErrors = [];
for i=1:length(k)
    learner = knnRegress(k(i),xtr,ytr);
    prediction = predict(learner,xtr);
    
    MSE = mean( (prediction-ytr).^2 );
    MeanSquaredErrors = [MeanSquaredErrors, MSE];
end
figure(2)
loglog(k,MeanSquaredErrors)
title('k value versus mean squared error on all data points')
ylabel('Mean square error')
xlabel('K Value')

pause;
%% c) 4-fold cross-validation
for k=1:100,
    for xval=1:4
        iTest = randperm(80,20);% choose 20 indices for testing
        iTrain = setdiff(1:80, iTest); % rest for testing
        xTest = xtr(iTest); yTest = ytr(iTest); % set up x and y values for test and train
        xTrain = xtr(iTrain); yTrain = ytr(iTrain);
        
        learner = knnRegress(k, xTrain,yTrain);
        prediction = predict(learner,xTest); 
        
        MSE = mean( (prediction-yTest).^2 ); 
        mse(k,xval) = MSE;
    end
end
k = [1:100];
hold on
loglog(k, mean(mse'))
title('k value versus mean squared error on all data points and using cross validation')
legend('all data points','cross validation')