%% Clear workspace and command window
clc; clear all; close all;
%%
xtr = load('data/top10/xtr.mat');
xtr = xtr.xtr;
xte = load('data/top10/xte.mat');
xte = xte.xte;

ytr = load('data/top10/ytr.mat');
ytr = ytr.ytr;
yte = load('data/top10/yte.mat');
yte = yte.yte;
%%
mdl = fitcknn(xtr,ytr,'NumNeighbors',1);
%%
total = 0;
for i=1:length(yte)
    predict = mdl.predict(xte(i,:));
    actual = yte(i,1);
    if predict ~= actual
        total = total +1;
    end
end
1- (total/length(yte))