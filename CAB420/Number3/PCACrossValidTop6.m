%% Clear workspace and command window
clc; clear all; close all;
%%
xtr = load('data/top6/xtr.mat');
xtr = xtr.xtr;
xte = load('data/top6/xte.mat');
xte = xte.xte;

ytr = load('data/top6/ytr.mat');
ytr = ytr.ytr;
yte = load('data/top6/yte.mat');
yte = yte.yte;

%%
Total = [xtr;xte];
%%
[datapca] = PCApreproccess(Total, 95);
%%
xtr = datapca(1:length(xtr),:);
%%
xte = datapca(length(xtr)+1:end,:);
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

%%
mdl = fitcknn(xtr,ytr,'NumNeighbors',2);
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

%%
mdl = fitcknn(xtr,ytr,'NumNeighbors',3);
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

%%
mdl = fitcknn(xtr,ytr,'NumNeighbors',4);
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

%%
mdl = fitcknn(xtr,ytr,'NumNeighbors',5);
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