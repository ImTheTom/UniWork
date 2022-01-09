%% Clear workspace and command window
clc; close all;

%% Load in the data and setting C
load('SVM/data_ps3_2.mat')
C = 1000;

%% Part a - Kernel of data set 1
set1Parameter = 0; %Set parmater
set1Model = svm_train(set1_train, @Klinear, set1Parameter, C); %Train model
svm_plot(set1_train, set1Model); %Plot model
title('Set 1 data with a SVM boundary line with a linear kernel')
xlabel('x1 value')
ylabel('x2 value')
svm_test(@Klinear,set1Parameter,C,set1_train,set1_test); %Test model
pause;

%% Part a - Kernel of data set 2
set2Parameter = 2;
set2Model = svm_train(set2_train, @Kpoly, set2Parameter, C);
svm_plot(set2_train, set2Model);
title('Set 1 data with a SVM boundary line with a polynomial kernel')
xlabel('x1 value')
ylabel('x2 value')
svm_test(@Kpoly,set2Parameter,C,set2_train,set2_test);
pause;

%% Part a - Kernel of data set 3
set3Parameter = 0.75;
set3Model = svm_train(set3_train, @Kgaussian, set3Parameter, C);
svm_plot(set3_train, set3Model);
title('Set 3 data with a SVM boundary line with a guassian kernel')
xlabel('x1 value')
ylabel('x2 value')
svm_test(@Kgaussian,set3Parameter,C,set3_train,set3_test);
pause;

%% Part b - Kernel's of data set 4
set4LinearParameter = 0; %Set parmater
set4LinearModel = svm_train(set4_train, @Klinear, set4LinearParameter, C); %Train model
set4LinearTest = sign(svm_discrim_func(set4_test.X,set4LinearModel)); %Get predicitons from test data and model
set4LinearErrors = find(set4LinearTest ~= set4_test.y); %Get indexs where the prediciton doesn't match value
set4LinearPercentError = (length(set4LinearErrors)/length(set4_test.y)) * 100 %Get % error
pause;

set4PolynomialParameter = 2;
set4PolynomialModel = svm_train(set4_train, @Kpoly, set4PolynomialParameter, C);
set4PolynomialTest = sign(svm_discrim_func(set4_test.X,set4PolynomialModel));
set4PolynomialErrors = find(set4PolynomialTest ~= set4_test.y);
set4PolynomialPercentError = (length(set4PolynomialErrors)/length(set4_test.y)) * 100
pause;

set4GuassianParameter = 1.5;
set4GuassianModel = svm_train(set4_train, @Kgaussian, set4GuassianParameter, C);
set4GuassianTest = sign(svm_discrim_func(set4_test.X,set4GuassianModel));
set4GuassianErrors = find(set4GuassianTest ~= set4_test.y);
set4GuassianPercentError = (length(set4GuassianErrors)/length(set4_test.y))*100
