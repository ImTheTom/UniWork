%% Clear workspace and command window
clc; clear all; close all;
%%
xtr = load('data/top8/xtr.mat');
xtr = xtr.xtr;
xte = load('data/top8/xte.mat');
xte = xte.xte;

ytr = load('data/top8/ytr.mat');
ytr = ytr.ytr;
yte = load('data/top8/yte.mat');
yte = yte.yte;
%%
[datapca] = PCApreproccess(xtr, 95);
%%
datapcatest = PCApreproccessSet(xte,size(datapca,2));
%%
mdl = fitcknn(datapca,ytr,'NumNeighbors',1);
%%
total = 0;
for i=1:length(yte)
    predict = mdl.predict(datapcatest(i,:));
    actual = yte(i,1);
    if predict ~= actual
        total = total +1;
    end
end
1- (total/length(yte))

%%
mdl = fitcknn(datapca,ytr,'NumNeighbors',2);
%%
total = 0;
for i=1:length(yte)
    predict = mdl.predict(datapcatest(i,:));
    actual = yte(i,1);
    if predict ~= actual
        total = total +1;
    end
end
1- (total/length(yte))

%%
mdl = fitcknn(datapca,ytr,'NumNeighbors',3);
%%
total = 0;
for i=1:length(yte)
    predict = mdl.predict(datapcatest(i,:));
    actual = yte(i,1);
    if predict ~= actual
        total = total +1;
    end
end
1- (total/length(yte))

%%
mdl = fitcknn(datapca,ytr,'NumNeighbors',4);
%%
total = 0;
for i=1:length(yte)
    predict = mdl.predict(datapcatest(i,:));
    actual = yte(i,1);
    if predict ~= actual
        total = total +1;
    end
end
1- (total/length(yte))

%%
mdl = fitcknn(datapca,ytr,'NumNeighbors',5);
%%
total = 0;
for i=1:length(yte)
    predict = mdl.predict(datapcatest(i,:));
    actual = yte(i,1);
    if predict ~= actual
        total = total +1;
    end
end
1- (total/length(yte))