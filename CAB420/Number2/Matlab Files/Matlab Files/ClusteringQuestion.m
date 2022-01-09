%% Clear workspace and command window
clc; close all; clear all;

%% Part a - Load in the data and Plot
iris = load('data/iris.txt');
Y = iris(:,5);
X = iris(:,1:2);
figure;
scatter(X(:,1), X(:,2), 20, Y)
title('Scatter plot of the iris data'); 
xlabel('Sepal length'); ylabel('Sepal width')
pause;

%% Part b - K means clustering
for k =[5 20]
    shortestDistance = inf;
    for it = 1:k
        [idx,centres,distance] = kmeans(X,k,'random');
        if(shortestDistance > distance) %If the shortest distance is larger than current distance calculated
            shortestIdx = idx; %Store the current values
            shortestCentres = centres;
            shortestDistance = distance;
        end
    end
    figure; hold on; plotClassify2D([], X,shortestIdx); %Display the optimal kmeans centorids
    plot(shortestCentres(:,1),shortestCentres(:,2), 'r*', 'MarkerSize', 10); hold off;
    title(['k-means clustering of iris data with a cluster of ' num2str(k)])
    xlabel('Sepal length'); ylabel('Sepal width')
    pause;
end

%% Part c - Agglomerative clustering
z = agglomCluster(X, 5, 'min'); %Compute single linkage agglo clustering
figure; plotClassify2D([], X,z);
title(['Agglomerative min clustering of iris data with a cluster of ' num2str(5)])
xlabel('Sepal length'); ylabel('Sepal width')
z = agglomCluster(X, 20, 'min');
figure; plotClassify2D([], X,z);
title(['Agglomerative min clustering of iris data with a cluster of ' num2str(20)])
xlabel('Sepal length'); ylabel('Sepal width')
pause;

z = agglomCluster(X, 5, 'max');%Compute complete linkage agglo clustering
figure; plotClassify2D([], X,z);
title(['Agglomerative max clustering of iris data with a cluster of ' num2str(5)])
xlabel('Sepal length'); ylabel('Sepal width')
z = agglomCluster(X, 20, 'max');
figure; plotClassify2D([], X,z);
title(['Agglomerative max clustering of iris data with a cluster of ' num2str(20)])
xlabel('Sepal length'); ylabel('Sepal width')
pause;

%% Part d - EM Gaussian Note: Uses figure 1 & 2 and takes a while to compute
for k =[5 20]
    shortestDistance = inf;
    for it = 1:10
        [idx,centres,distance] = emCluster(X,k,'random');
        if(shortestDistance > distance) %If the shortest distance is larger than current distance calculated
            shortestIdx = idx;%Store the current values
            shortestCentres = centres;
            shortestDistance = distance;
        end
    end
    pause;
end