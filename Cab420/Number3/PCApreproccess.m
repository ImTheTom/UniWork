function [Vout, mu] = PCApreproccess(data, percentvar )
%PCApreproccess This function applies pca to reduce the dimentionality of
%the data

% input of data must have columns representing the features
% data must not have the target features
% percentvar is the percentage of the variance to keep eg. 95

% datapca is the reduced dimention version of data

% step one: take the mean from the data 
mu = mean(data);
data_m = bsxfun(@minus, data, mu); % efficent operation - subtract mean from data

[m,n] = size(data_m); % get the dimention of data

[U, S, V] = svd(data_m); % apply svd where U*S: principal components, V: principal direction
W = U*S;

% calculate the percentage of variance
S_0 =sum(sum(S.^2));
count = 0;
Scalc = 0;
while  Scalc < percentvar 
    count = count +1;
    Scalc(count) = sum(sum(S(1:count,1:count).^2))/S_0; 
    Scalc(count) = Scalc(count)* 100; % turn into percentage 
    
end

Vout = V(1:count,:);


%plotting
hold on
plot(Scalc)
line([0 count],[95 95],'LineStyle','--','Color','red');
line([count count],[0 95], 'LineStyle','--','Color','red');
hold off
title('Variance Vs Number of Principal Components')
xlabel('Number of Principal Components')
ylabel('Variance (%)')
legend('Measured',sprintf('Threshold of %d %%',percentvar),sprintf('Occurs with %d Principal Components',count))


    

end

