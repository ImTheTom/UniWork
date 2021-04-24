%% Clear workspace and command window
clc; clear all; close all;

%%
data=load('data/dataSetFullv2.mat');
data = data.dataSetFull;

%%
data = GetMostEmails(data, 6);

%%
[ training, testing ] = TrainingAndTesting( data, 0.8 );

%%
bag = load('data/bagStemmed.mat');
bag = bag.bagStemmed;
%%

Training_word_features=[];
for i=1:length(training)
    email = training(i,2);
    email = CleanEmail(email);

    word_indcies = ProcessEmail(email, bag);
    features = EmailFeatures(word_indcies,bag);
    Training_word_features=[Training_word_features,features];
end

Testing_word_features=[];
for i=1:length(testing)
    email = testing(i,2);
    email = CleanEmail(email);

    word_indcies = ProcessEmail(email, bag);
    features = EmailFeatures(word_indcies,bag);
    Testing_word_features=[Testing_word_features,features];
end

%%
xtr = Training_word_features';
ytr = training(:,1);
%%
xte = Testing_word_features';
yte = testing(:,1);
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