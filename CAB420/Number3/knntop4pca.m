%% Clear workspace and command window
clc; clear all; close all;
%% Load in testing and trianing features
xtr = load('data/top4/xtr.mat');
xtr = xtr.xtr;
xte = load('data/top4/xte.mat');
xte = xte.xte;

ytr = load('data/top4/ytr.mat');
ytr = ytr.ytr;
yte = load('data/top4/yte.mat');
yte = yte.yte;
%% Create PCA model
[V, mu] = PCApreproccess(xtr, 95); % input data, percent of var to keep
%% Do pca on training and testing
% W is scores and V is loadings or coefficents 
xtr = bsxfun(@minus,xtr, mu)*V'; % apply to training
xte = bsxfun(@minus,xte, mu)*V'; % apply to test
%% Fit model
mdl = fitcknn(xtr,ytr,'NumNeighbors',1);
%% Find training error
fprintf("Training")
total = 0;
for i=1:length(ytr)
    predict = mdl.predict(xtr(i,:));
    actual = ytr(i,1);
    if predict ~= actual
        total = total +1;
    end
end
(total/length(ytr))
%% Find testing error
fprintf("Testing")
total = 0;
for i=1:length(yte)
    predict = mdl.predict(xte(i,:));
    actual = yte(i,1);
    if predict ~= actual
        total = total +1;
    end
end
(total/length(yte))