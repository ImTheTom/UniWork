clear all
close all

load('top2\xtr.mat');
load('top2\xte.mat');

[V, mu] = PCApreproccess(xtr, 95); % input data, percent of var to keep

% W is scores and V is loadings or coefficents 
xtrPCA = bsxfun(@minus,xtr, mu)*V'; % apply to training
xtePCA = bsxfun(@minus,xte, mu)*V'; % apply to test

%save('xtePCA.mat','xtePCA')
%save('xtrPCA.mat','xtrPCA')
