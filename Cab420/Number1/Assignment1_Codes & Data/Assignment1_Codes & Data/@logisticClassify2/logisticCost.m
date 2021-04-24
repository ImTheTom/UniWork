function [ J ] = logisticCost( obj, X, Y, reg)
%LOGISTICCOST Used to calculate the logistic cost
m = length(Y);
theta = obj.wts;
sigma = logistic(obj, X);
J = 1 / m * (sum(-Y .* log(sigma) - (1 - Y) .* log(1 - sigma)) + reg*sum(theta.^2));
end