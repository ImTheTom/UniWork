%% Clear workspace and command window
clc; clear all; close all;

%% Load in and setup data
iris = load('data/iris.txt');
pi = randperm(size(iris,1));
Y=iris(pi,5); X = iris(pi,1:2);

%% a) Plot the data
XClass0 = X(find(Y==0),:);
XClass1 = X(find(Y==1),:); 
XClass2 = X(find(Y==2),:); 

hold on
plot(XClass0(:,1),XClass0(:,2), 'bo')
plot(XClass1(:,1),XClass1(:,2), 'go')
plot(XClass2(:,1),XClass2(:,2), 'ro')
title('Sepel lengths and widths of different Iris')
ylabel('sepel width(cm)')
xlabel('sepel length(cm)')
legend('Setosa','Versicolour', 'Virginica')
hold off

pause;
%% b) 1-nearest-neighbor predictor
learner = knnClassify(1,X,Y);
class2DPlot(learner,X,Y);
title('1 nearest neighbour classifier on Sepel lengths and widths of different Iris')
ylabel('sepel width(cm)')
xlabel('sepel length(cm)')
legend('Setosa','Versicolour', 'Virginica')

pause;
%% c) multiple nearest neighbor predictors
kValues =[1,3,10,30];
for i=1:length(kValues)
    learner = knnClassify(kValues(i),X,Y);
    class2DPlot(learner,X,Y);
    title([num2str(kValues(i)) ' nearest neighbour classifier on Sepel lengths and widths of different Iris'])
    ylabel('sepel width(cm)')
    xlabel('sepel length(cm)')
    legend('Setosa','Versicolour', 'Virginica')
end

pause;
%% d) cross validation
kvalues=[1,2,5,10,50,100,200]; 
for i=1:length(kvalues)
    iTest = randperm(148,30);% choose 20 indices for testing 188
    iTrain = setdiff(1:148, iTest); % rest for testing
    xTest = X(iTest,:); yTest = Y(iTest,:);
    xTrain = X(iTrain,:); yTrain = Y(iTrain,:);
    
    learner = knnClassify(kvalues(i),xTrain,yTrain); % train model on X/Ytrain 
    Yhat = predict(learner,xTest);% predict results on X/Yvalid 
    
    total = 0; % number of incorrect values
    for j=1:length(yTest)
        if(Yhat(j)~=yTest(j))
            total=total+1;
        end
    end
    err(i) = total;
end

kvalues=[1,2,5,10,50,100,200]; 
figure(1)
plot(kvalues,err)
title('How complexity of a nearest neighbour classifier affects new data')
ylabel('number of wrong classified data out of 30')
xlabel('k classifier')