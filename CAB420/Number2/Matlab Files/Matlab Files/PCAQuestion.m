%% Clear workspace and command window
clc; close all; clear all;
%% Load in the data
X = load('data/faces.txt');

%% Part a - Data zero-mean
mu = mean(X);
Xm = bsxfun(@minus, X, mu); %calulate data zero mean
[U,S,V] = svd(Xm); %Calculate SVD
W = U*S; %Compute W

%% Part b - Approximation to Xo
mse = zeros(1,10); %Initialise empty vector
for K=1:10
    prediction = W(:,1:K)*V(:,1:K)';
    mse(K) = mean(mean((Xm-prediction).^2)); %Store iteration of mse of actual and predicted value
end
figure;
plot(1:10, mse); %Plot mse values
title('Mean square error versus the number of W and V values used')
ylabel('Mean square error')
xlabel('number of W and V values used to predict Xm')
pause;

%% Part c - First few prcinipal directions of data
for j=1:3
    scale = 2*median(abs(W(:,j))); %Compute alpha value
    a = mu+scale*V(:,j)'; %Calculate the plus direction
    b = mu-scale*V(:,j)'; %Calculate the minus direction 
    figure(1) %Rest of code is displaying the values
    img = reshape(a(1,:),[24 24]);
    imagesc(img);
    axis square;
    colormap gray;
    title(['mu + with a j value of ' num2str(j)])
    figure(2)
    img2 = reshape(b(1,:),[24 24]);
    imagesc(img2);
    axis square;
    colormap gray;
    title(['mu - with a j value of ' num2str(j)])
    pause;
end

%% Part d - Latent space
idx = randperm(4916, 25); %Select 25 random faces
figure;
hold on;
axis ij;
colormap(gray);
range = max(W(idx, 1:2)) - min(W(idx, 1:2));
scale = [200 200]./range;
for i=idx
    imagesc(W(i,1)*scale(1),W(i,2)*scale(2), reshape(X(i,:),24,24)); %Display face at coefficient
end
pause;

%% Part e - Reconstruct faces
k_values = [5, 10, 50];
faces = randperm(4916, 2); %Select 2 random faces
for i=faces
    original = X(i, :); %Show original
    figure;
    original = reshape(original, [24 24]);
    imagesc(original); axis square; colormap gray; title(['original at index ' num2str(i)])
    for k=k_values
        figure;
        current = mu+W(i,1:k)*V(:,1:k)'; %Reconstruct face to k number of values
        current = reshape(current, [24 24]);
        imagesc(current); axis square; colormap gray; title(['reconstructed with a k value of ' num2str(k)])
    end
end
